import 'package:flutter/material.dart';
import 'package:rnnett/screens/account.dart';
import 'package:rnnett/screens/home_screen.dart';
import 'package:rnnett/screens/info.dart';
import 'package:rnnett/screens/wifi_screen.dart';

class Fragment extends StatefulWidget {
  const Fragment({super.key});

  @override
  State<Fragment> createState() => _FragmentState();
}

class _FragmentState extends State<Fragment> {
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  final Color mainColor = const Color.fromARGB(255, 114, 96, 206);
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(child: currentScreen, bucket: bucket),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: currentTab == 0 ? const Color(0xFF9C88FF) : mainColor,
        child: Icon(Icons.home, color: Colors.white),

        onPressed: () {
          setState(() {
            currentScreen = HomeScreen();
            currentTab = 0;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          //width: MediaQuery.of(context).size.width / 0.1,
          height: kBottomNavigationBarHeight,
          child: Container(
            width: MediaQuery.of(context).size.width / 0.1,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF9C88FF),
                  Color(0xFF7F6BFF),
                  Color(0xFF5E4BFF),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 30,
                      onPressed: () {
                        setState(() {
                          currentScreen = WifiScreen();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color: currentTab == 1
                                ? Colors.purple.shade100
                                : Colors.white70,
                          ),
                          Text(
                            'Wifi',
                            style: TextStyle(
                              color: currentTab == 1
                                  ? Colors.purple.shade100
                                  : Colors.white70,
                              fontSize: 10,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = WifiScreen();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.payment,
                            color: currentTab == 2
                                ? Colors.purple.shade100
                                : Colors.white70,
                          ),
                          Text(
                            'Payment',
                            style: TextStyle(
                              color: currentTab == 2
                                  ? Colors.purple.shade100
                                  : Colors.white70,
                              fontSize: 10,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Right Tab bar icons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Account();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.account_circle,
                            color: currentTab == 3
                                ? Colors.purple.shade100
                                : Colors.white70,
                          ),
                          Text(
                            'Account',
                            style: TextStyle(
                              color: currentTab == 3
                                  ? Colors.purple.shade100
                                  : Colors.white70,
                              fontSize: 10,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Info();
                          currentTab = 4;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.info,
                            color: currentTab == 4
                                ? Colors.purple.shade100
                                : Colors.white70,
                          ),
                          Text(
                            'Info',
                            style: TextStyle(
                              color: currentTab == 4
                                  ? Colors.teal.shade300
                                  : Colors.white70,
                              fontSize: 10,
                              fontFamily: 'OpenSans',
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
        ),
      ),
    );
  }
}
