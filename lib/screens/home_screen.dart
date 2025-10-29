import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math';
import 'dart:async';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Speed test variables
  Timer? _testTimer;
  Random _random = Random();
  double downloadRate = 0;
  double uploadRate = 0;
  double _currentSpeedValue = 0;
  double _progressPercent = 0;
  bool testingSpeed = false;
  String? progressMessage;
  String currentTestType = '';

  Color _gaugeColor(double value) {
    if (value < 26) return Colors.purple; // Poor
    if (value < 50) return Colors.red; // Fair
    if (value < 75) return Colors.orange; // Good
    return Colors.green; // Excellent
  }

  @override
  void dispose() {
    _testTimer?.cancel();
    super.dispose();
  }

  void _startSpeedTest() async {
    if (testingSpeed) return;

    setState(() {
      testingSpeed = true;
      currentTestType = 'Combined';
      progressMessage = 'Memulai tes kecepatan...';
      _progressPercent = 0;
      _currentSpeedValue = 0;
    });

    // Simulate download test
    await _simulateDownloadTest();

    // Wait a moment between tests
    await Future.delayed(const Duration(seconds: 1));

    // Simulate upload test
    await _simulateUploadTest();

    setState(() {
      testingSpeed = false;
      progressMessage = 'Tes kecepatan selesai';
    });
  }

  Future<void> _simulateDownloadTest() async {
    const testDuration = Duration(seconds: 5);
    const updateInterval = Duration(milliseconds: 100);
    int elapsedMs = 0;

    _testTimer?.cancel();
    _testTimer = Timer.periodic(updateInterval, (timer) {
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
          downloadRate = currentSpeed.toDouble();
          _currentSpeedValue = currentSpeed.toDouble();
          _progressPercent = progress.toDouble();
          progressMessage = 'Download: ${currentSpeed.toStringAsFixed(1)} Mb/s';
        });
      }

      if (progress >= 100) {
        timer.cancel();
      }
    });

    await Future.delayed(testDuration);
    _testTimer?.cancel();
  }

  Future<void> _simulateUploadTest() async {
    const testDuration = Duration(seconds: 5);
    const updateInterval = Duration(milliseconds: 100);
    int elapsedMs = 0;

    _testTimer?.cancel();
    _testTimer = Timer.periodic(updateInterval, (timer) {
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
          uploadRate = currentSpeed.toDouble();
          _currentSpeedValue = currentSpeed.toDouble();
          _progressPercent = progress.toDouble();
          progressMessage = 'Upload: ${currentSpeed.toStringAsFixed(1)} Mb/s';
        });
      }

      if (progress >= 100) {
        timer.cancel();
      }
    });

    await Future.delayed(testDuration);
    _testTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgrnet.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 320,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 50,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF9C88FF),
                            Color(0xFF7F6BFF),
                            Color(0xFF5E4BFF),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      // showimage == "null" || showimage.isEmpty
                                      //     ?
                                      AssetImage('assets/userfp.jpg'),
                                  // : NetworkImage(showimage) as ImageProvider,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'My Dashboard',
                                        style: GoogleFonts.comfortaa(
                                          color: const Color(0xFF253C6A),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Hi, Selamat Datang kembali',
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: const Color(0xFF253C6A),
                                          fontSize: 11,
                                          height: 1,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.notifications),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3EEFF),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: SfRadialGauge(
                                      enableLoadingAnimation: true,
                                      animationDuration: 1200,
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          minimum: 0,
                                          maximum: 100,
                                          axisLabelStyle: GaugeTextStyle(
                                            fontSize: 10,
                                          ),
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                              startValue: 0,
                                              endValue: 26,
                                              color: Colors.purple,
                                              label: 'Poor',
                                              labelStyle: GaugeTextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                            GaugeRange(
                                              startValue: 26,
                                              endValue: 50,
                                              color: Colors.red,
                                              label: 'Fair',
                                              labelStyle: GaugeTextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                            GaugeRange(
                                              startValue: 50,
                                              endValue: 75,
                                              color: Colors.orange,
                                              label: 'Good',
                                              labelStyle: GaugeTextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                            GaugeRange(
                                              startValue: 75,
                                              endValue: 100,
                                              color: Colors.green,
                                              label: 'Excellent',
                                              labelStyle: GaugeTextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                          ],
                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                              value: testingSpeed
                                                  ? _currentSpeedValue
                                                  : (downloadRate > 0
                                                        ? downloadRate
                                                        : 0),
                                              needleColor: _gaugeColor(
                                                testingSpeed
                                                    ? _currentSpeedValue
                                                    : (downloadRate > 0
                                                          ? downloadRate
                                                          : 0),
                                              ),
                                              needleStartWidth: 1,
                                              needleEndWidth: 6,
                                              knobStyle: KnobStyle(
                                                knobRadius: 0.06,
                                                color: _gaugeColor(
                                                  testingSpeed
                                                      ? _currentSpeedValue
                                                      : (downloadRate > 0
                                                            ? downloadRate
                                                            : 0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${DateTime.now().hour}:${DateTime.now().minute}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${DateFormat('MMM dd,yyyy').format(DateTime.now())} - ${DateFormat('EEEE').format(DateTime.now())}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blueGrey,
                                    ),
                                    textAlign: TextAlign.center,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: testingSpeed
                                        ? null
                                        : _startSpeedTest,
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(0, 40),
                                      shadowColor: const Color.fromARGB(
                                        226,
                                        133,
                                        129,
                                        129,
                                      ),
                                      backgroundColor: testingSpeed
                                          ? Colors.grey
                                          : const Color(0xFF7977FC),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (testingSpeed)
                                          const SizedBox(
                                            width: 14,
                                            height: 14,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                            ),
                                          ),
                                        if (testingSpeed)
                                          const SizedBox(width: 8),
                                        Text(
                                          testingSpeed
                                              ? 'Testing...'
                                              : 'Test Speed',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    testingSpeed
                                        ? progressMessage ?? 'Testing...'
                                        : downloadRate > 0
                                        ? 'Download: ${downloadRate.toStringAsFixed(1)} Mbps'
                                        : '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: testingSpeed
                                          ? const Color(0xFF9C88FF)
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  if (uploadRate > 0)
                                    Text(
                                      'Upload: ${uploadRate.toStringAsFixed(1)} Mbps',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        height: 0.5,
                                      ),
                                    ),
                                  if (testingSpeed)
                                    Column(
                                      children: [
                                        const SizedBox(height: 8),
                                        LinearProgressIndicator(
                                          value: _progressPercent / 100,
                                          backgroundColor: Colors.grey[300],
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                Color
                                              >(Color(0xFF9C88FF)),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.list, color: Color(0xFF9C88FF), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Device Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 87, 85, 85),
                              blurRadius: 4,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Model',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const Text(
                                        'FF670',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'PPPoE Username',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const Text(
                                        'server@mnet.net',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Serial Number',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const Text(
                                        'ZTEGC4A366C6',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'MAC Address',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const Text(
                                        '5c:3a:3d:b7:1d:1e',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
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
                      const SizedBox(height: 16),
                      // Device Count Card
                      const Row(
                        children: [
                          Icon(Icons.list, color: Color(0xFF9C88FF), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Informasi Perangkat',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 87, 85, 85),
                              blurRadius: 4,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jumlah',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.laptop,
                                      color: Color(0xFF9C88FF),
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '5',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Status',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.wifi,
                                      color: Color(0xFF9C88FF),
                                      size: 15,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Online',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    CircleAvatar(
                                      radius: 4,
                                      backgroundColor: Color(0xFF4CAF50),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Detail >',
                                style: TextStyle(
                                  color: Color(0xFF9C88FF),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Network Statistics Card
                      const Row(
                        children: [
                          Icon(
                            Icons.bar_chart,
                            color: Color(0xFF9C88FF),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Network Statistic',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF9C88FF),
                                      Color(0xFF7F6BFF),
                                      Color(0xFF5E4BFF),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(
                                  Icons.power,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                children: [
                                  Text(
                                    'RX Power',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '-6.95 dBm',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      // height: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFC19BF2),
                                      Color(0xFF9C69F5),
                                      Color(0xFF7977FC),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(
                                  Icons.access_time,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Uptime',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '28d 04:18:31',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFC19BF2),
                                      Color(0xFF9C69F5),
                                      Color(0xFF7977FC),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(
                                  Icons.access_time,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Connected Users',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Card(
                                        color: Color(0xFF78A0EB),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            '2.4G: 3',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        color: Color(0xFF147B52),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            '5G: 2',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
