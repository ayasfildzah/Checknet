import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rnnett/fragment.dart';
// import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgrnet.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.7,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 20, right: 20),
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
                      borderRadius: BorderRadius.only(
                        // bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(180),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 80),
                        Text(
                          'Selamat Datang!',
                          style: GoogleFonts.dongle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            height: 0.8,
                          ),
                        ),
                        Text(
                          'Hai, Senang bertemu denganmu kembali',
                          style: GoogleFonts.comfortaa(
                            fontSize: 12,
                            color: Colors.white,
                            height: 0.5,
                          ),
                        ),
                        SizedBox(height: 100),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/logornnet.png',
                            width: 210,
                            // height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 380,
                    left: 30,
                    right: 30,
                    child: Container(
                      padding: const EdgeInsets.all(30),
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
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // WebPortal Title
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.wifi,
                                  color: Color.fromARGB(255, 11, 10, 15),
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'WebPortal',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            // Customer ID Input
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Masukan nomor id pelanggan Anda',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 8),
                                // Password Input
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF6A4FAD),
                                        blurRadius: 1,
                                        offset: const Offset(1, 2),
                                      ),
                                    ],
                                  ),

                                  child: TextField(
                                    controller: _passwordController,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                      // prefixIcon: const Icon(
                                      //   Icons.person,
                                      //   color: Colors.grey,
                                      // ),
                                      suffixIcon: const Icon(
                                        Icons.book,
                                        color: Color.fromARGB(
                                          255,
                                          196,
                                          150,
                                          225,
                                        ),
                                      ),
                                      hintText: 'no pelanggan ini disini',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 16,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Register Link
                                const Text(
                                  'Apabila belum terdaftar menghubungi admin',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),
                            // Login Button
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF6F71F9),
                                    Color(0xFF6F71F9),
                                    Color(0xFF9C88FF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),

                              child: MaterialButton(
                                onPressed: () {
                                  print('Masuk');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Fragment(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.login,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Masuk',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
