import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math';
import 'dart:async';

class Showspeed extends StatefulWidget {
  const Showspeed({super.key});

  @override
  State<Showspeed> createState() => _ShowspeedState();
}

class _ShowspeedState extends State<Showspeed> {
  Timer? _testTimer;
  Random _random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _testTimer?.cancel();
    super.dispose();
  }

  double downloadRate = 0;
  double uploadRate = 0;

  bool testingDownload = false;
  bool testingUpload = false;
  bool testingCombined = false;
  String? progressMessage;
  String currentTestType = '';

  List<Map<String, dynamic>> testHistory = [];

  void _startDownloadTest() async {
    if (testingDownload || testingUpload || testingCombined) return;

    setState(() {
      testingDownload = true;
      currentTestType = 'Download';
      progressMessage = 'Initializing download test...';
    });

    _simulateSpeedTest('download');
  }

  void _startUploadTest() async {
    if (testingDownload || testingUpload || testingCombined) return;

    setState(() {
      testingUpload = true;
      currentTestType = 'Upload';
      progressMessage = 'Initializing upload test...';
    });

    _simulateSpeedTest('upload');
  }

  void _simulateSpeedTest(String testType) async {
    const testDuration = Duration(seconds: 10);
    const updateInterval = Duration(milliseconds: 100);
    int elapsedMs = 0;

    _testTimer?.cancel();
    _testTimer = Timer.periodic(updateInterval, (timer) {
      elapsedMs += updateInterval.inMilliseconds;
      final progress = (elapsedMs / testDuration.inMilliseconds * 100).clamp(
        0,
        100,
      );

      // Simulate realistic speed variations
      double baseSpeed;
      if (testType == 'download') {
        baseSpeed = 15 + _random.nextDouble() * 25; // 15-40 Mbps
      } else {
        baseSpeed = 5 + _random.nextDouble() * 15; // 5-20 Mbps
      }

      // Add some variation during the test
      final variation = 0.8 + _random.nextDouble() * 0.4; // 0.8-1.2 multiplier
      final currentSpeed = baseSpeed * variation;

      setState(() {
        if (testType == 'download') {
          downloadRate = currentSpeed;
        } else {
          uploadRate = currentSpeed;
        }
        progressMessage =
            'Testing $testType... ${currentSpeed.toStringAsFixed(2)} Mb/s';
      });

      if (progress >= 100) {
        timer.cancel();
        _completeTest(testType, currentSpeed);
      }
    });
  }

  void _completeTest(String testType, double finalSpeed) {
    setState(() {
      if (testType == 'download') {
        downloadRate = finalSpeed;
        testingDownload = false;
      } else {
        uploadRate = finalSpeed;
        testingUpload = false;
      }
      progressMessage = '$testType test completed';
      _addToHistory(testType, finalSpeed);
    });
  }

  void _startCombinedTest() async {
    if (testingDownload || testingUpload || testingCombined) return;

    setState(() {
      testingCombined = true;
      currentTestType = 'Combined';
      progressMessage = 'Memulai tes kecepatan internet...';
      downloadRate = 0;
      uploadRate = 0;
    });

    // Jalankan download dan upload secara bersamaan
    final downloadFuture = _runDownloadTest();
    final uploadFuture = _runUploadTest();

    // Tunggu kedua test selesai
    await Future.wait([downloadFuture, uploadFuture]);

    if (mounted) {
      setState(() {
        testingCombined = false;
        progressMessage = 'Tes kecepatan selesai!';
        _addToHistory('Combined', downloadRate, uploadRate);
      });
    }
  }

  Future<void> _runDownloadTest() async {
    const testDuration = Duration(seconds: 8);
    const updateInterval = Duration(milliseconds: 100);
    int elapsedMs = 0;

    Timer? timer;
    timer = Timer.periodic(updateInterval, (t) {
      elapsedMs += updateInterval.inMilliseconds;
      final progress = (elapsedMs / testDuration.inMilliseconds * 100).clamp(
        0,
        100,
      );

      // Simulate realistic download speed
      final baseSpeed = 20 + _random.nextDouble() * 30; // 20-50 Mbps
      final variation = 0.8 + _random.nextDouble() * 0.4;
      final currentSpeed = baseSpeed * variation;

      if (mounted) {
        setState(() {
          downloadRate = currentSpeed;
          if (testingCombined) {
            progressMessage =
                'Download: ${currentSpeed.toStringAsFixed(1)} Mb/s | Upload: ${uploadRate.toStringAsFixed(1)} Mb/s';
          }
        });
      }

      if (progress >= 100) {
        t.cancel();
      }
    });

    await Future.delayed(testDuration);
    timer.cancel();
  }

  Future<void> _runUploadTest() async {
    const testDuration = Duration(seconds: 8);
    const updateInterval = Duration(milliseconds: 100);
    int elapsedMs = 0;

    Timer? timer;
    timer = Timer.periodic(updateInterval, (t) {
      elapsedMs += updateInterval.inMilliseconds;
      final progress = (elapsedMs / testDuration.inMilliseconds * 100).clamp(
        0,
        100,
      );

      // Simulate realistic upload speed
      final baseSpeed = 8 + _random.nextDouble() * 17; // 8-25 Mbps
      final variation = 0.8 + _random.nextDouble() * 0.4;
      final currentSpeed = baseSpeed * variation;

      if (mounted) {
        setState(() {
          uploadRate = currentSpeed;
          if (testingCombined) {
            progressMessage =
                'Download: ${downloadRate.toStringAsFixed(1)} Mb/s | Upload: ${currentSpeed.toStringAsFixed(1)} Mb/s';
          }
        });
      }

      if (progress >= 100) {
        t.cancel();
      }
    });

    await Future.delayed(testDuration);
    timer.cancel();
  }

  void _addToHistory(
    String testType,
    double downloadSpeed, [
    double? uploadSpeed,
  ]) {
    final testResult = {
      'timestamp': DateTime.now(),
      'testType': testType,
      'downloadSpeed': downloadSpeed,
      'uploadSpeed': uploadSpeed ?? 0.0,
    };
    setState(() {
      testHistory.insert(0, testResult);
      if (testHistory.length > 10) {
        testHistory.removeLast();
      }
    });
  }

  void _clearHistory() {
    setState(() {
      testHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tes Kecepatan Internet'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            if (testHistory.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.history),
                onPressed: () => _showHistoryDialog(),
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Speed Gauge
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      currentTestType.isEmpty
                          ? 'Siap untuk Tes Kecepatan'
                          : testingCombined
                          ? 'Sedang Menguji Kecepatan Internet'
                          : 'Testing $currentTestType',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SfRadialGauge(
                      enableLoadingAnimation: true,
                      animationDuration: 2000,
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0,
                              endValue: 25,
                              color: Colors.green,
                              label: 'Excellent',
                            ),
                            GaugeRange(
                              startValue: 25,
                              endValue: 50,
                              color: Colors.orange,
                              label: 'Good',
                            ),
                            GaugeRange(
                              startValue: 50,
                              endValue: 75,
                              color: Colors.red,
                              label: 'Fair',
                            ),
                            GaugeRange(
                              startValue: 75,
                              endValue: 100,
                              color: Colors.purple,
                              label: 'Poor',
                            ),
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: downloadRate > uploadRate
                                  ? downloadRate
                                  : uploadRate,
                              needleColor: Colors.blue,
                              needleStartWidth: 1,
                              needleEndWidth: 8,
                              knobStyle: const KnobStyle(
                                knobRadius: 0.08,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${(downloadRate > uploadRate ? downloadRate : uploadRate).toStringAsFixed(1)}",
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const Text(
                                      "Mb/s",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              angle: 90,
                              positionFactor: 0.5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Progress indicator
                    if (testingDownload || testingUpload || testingCombined)
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.blue.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.download,
                                          color: Colors.green,
                                          size: 24,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${downloadRate.toStringAsFixed(1)}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const Text(
                                          'Mb/s',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 40,
                                      width: 1,
                                      color: Colors.grey[300],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.upload,
                                          color: Colors.orange,
                                          size: 24,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${uploadRate.toStringAsFixed(1)}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        const Text(
                                          'Mb/s',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                if (progressMessage != null)
                                  Text(
                                    progressMessage!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Test Results
              Row(
                children: [
                  Expanded(
                    child: _buildResultCard(
                      'Download',
                      downloadRate,
                      Icons.download,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildResultCard(
                      'Upload',
                      uploadRate,
                      Icons.upload,
                      Colors.blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Test Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed:
                          (testingDownload || testingUpload || testingCombined)
                          ? null
                          : _startCombinedTest,
                      icon: Icon(
                        testingCombined ? Icons.stop : Icons.speed,
                        size: 28,
                      ),
                      label: Text(
                        testingCombined
                            ? 'Menghentikan Tes...'
                            : 'Mulai Tes Kecepatan',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: testingCombined
                            ? Colors.red
                            : Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Individual test buttons (smaller)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              (testingDownload ||
                                  testingUpload ||
                                  testingCombined)
                              ? null
                              : _startDownloadTest,
                          icon: const Icon(Icons.download, size: 20),
                          label: const Text('Download'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              (testingDownload ||
                                  testingUpload ||
                                  testingCombined)
                              ? null
                              : _startUploadTest,
                          icon: const Icon(Icons.upload, size: 20),
                          label: const Text('Upload'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(
    String title,
    double speed,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${speed.toStringAsFixed(2)} Mb/s',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Riwayat Tes'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: testHistory.isEmpty
              ? const Center(child: Text('Belum ada riwayat tes'))
              : ListView.builder(
                  itemCount: testHistory.length,
                  itemBuilder: (context, index) {
                    final test = testHistory[index];
                    final timestamp = test['timestamp'] as DateTime;
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          test['testType'] == 'Download'
                              ? Icons.download
                              : test['testType'] == 'Upload'
                              ? Icons.upload
                              : Icons.speed,
                          color: test['testType'] == 'Download'
                              ? Colors.green
                              : test['testType'] == 'Upload'
                              ? Colors.blue
                              : Colors.orange,
                        ),
                        title: Text(test['testType']),
                        subtitle: Text(
                          '${test['downloadSpeed'].toStringAsFixed(2)} Mb/s ↓ / ${test['uploadSpeed'].toStringAsFixed(2)} Mb/s ↑',
                        ),
                        trailing: Text(
                          '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
          if (testHistory.isNotEmpty)
            TextButton(
              onPressed: () {
                _clearHistory();
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
        ],
      ),
    );
  }
}
