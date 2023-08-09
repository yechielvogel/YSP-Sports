import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/services.dart';

class Globals {
  final ValueNotifier<int> score1 = ValueNotifier<int>(0);
  final ValueNotifier<int> score2 = ValueNotifier<int>(0);
  late ValueNotifier<int> teamIndex1 = ValueNotifier<int>(0);
  late ValueNotifier<int> teamIndex2 = ValueNotifier<int>(0);
  Color? main1;
  Color? main2;
  var winner = '';
  var looser = '';
  var winnerscore = '';
  var looserscore = '';
  var draw = '';
  var whatsappmessage = '';
  var team1 = '';
  var team2 = '';
}

Globals globals = Globals(); // Create a singleton instance of Globals

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const List<String> teamNames = [
    'Nemenov Knights', // Knights // light grey
    'Chain Chariots', // maroon
    'Paritcher Poachers', //dark pink
    'Rashbatz Riders', // bage
    'Charitonov Chasers', // grey
    'Kesselman Kings', // light Green.
    'Althoise Archers', // green
    'Pariz parkers', // brown
    'Kletzker Crackers', //orrange
    'Futerfas Fighters', //purpul
    'Maharil Marchers', //blue
    'Munkis Markes', //light pink
    'Dvorkin Dodgers', //blue
    'Vilenkin Vacuums', // white
    'Homler Hitchers', //red
    'Levitin Lakers', //yellow.
    // Add more names here
  ];

  void resetScores() {
    globals.score1.value = 0;
    globals.score2.value = 0;
  }

  // ignore: non_constant_identifier_names
  Future<void> Winner() async {
    if (globals.score1.value > globals.score2.value) {
      globals.winner = MyApp.teamNames[globals.teamIndex1.value];
      globals.winnerscore = globals.score1.value.toString();
      globals.looserscore = globals.score2.value.toString();
      globals.looser = MyApp.teamNames[globals.teamIndex2.value];
      String name1 = globals.looser;
      name1 = removeSpaces(name1);
      globals.looser = name1;
      String name = globals.winner;
      name = removeSpaces(name);
      globals.winner = name;
      globals.whatsappmessage =
          'https://wa.me/+18623601784?text=${globals.winner}%20won%20${globals.looser}%20${globals.winnerscore}%20-%20${globals.looserscore}';
      print(globals.whatsappmessage);
    } else if (globals.score2.value > globals.score1.value) {
      globals.winner = MyApp.teamNames[globals.teamIndex2.value];
      globals.winnerscore = globals.score2.value.toString();
      globals.looserscore = globals.score1.value.toString();
      globals.looser = MyApp.teamNames[globals.teamIndex1.value];
      String name = globals.winner;
      name = removeSpaces(name);
      globals.winner = name;
      String name2 = globals.looser;
      name2 = removeSpaces(name2);
      globals.looser = name2;
      globals.whatsappmessage =
          'https://wa.me/+18623601784?text=${globals.winner}%20won%20${globals.looser}%20${globals.winnerscore}%20-%20${globals.looserscore}';
      print(globals.whatsappmessage);
    } else {
      globals.team1 = MyApp.teamNames[globals.teamIndex1.value];
      globals.team2 = MyApp.teamNames[globals.teamIndex2.value];
      String team1 = globals.team1;
      team1 = removeSpaces(team1);
      globals.team1 = team1;
      String team2 = globals.team2;
      team2 = removeSpaces(team2);
      globals.team2 = team2;
      globals.whatsappmessage =
          'https://wa.me/+18623601784?text=Draw%20${globals.team1}%20${globals.score1.value.toString()}%20-%20${globals.score2.value.toString()}%20${globals.team2}%20';
      print(globals.whatsappmessage);
    }
    print(globals.winner);
  }

  String removeSpaces(String input) {
    return input.replaceAll(' ', '%20');
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    _launchURL() async {
      final url = globals.whatsappmessage;
      if (await canLaunch(url)) {
        await launch(url);
      }
    }

// 'https://wa.me/+18623601784?text=The%20${globals.winner}%20won';
//+18623601784
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Material(
              child: MyHomePage(
                title: 'Flutter Demo Home Page',
                key: const Key('hello'),
                resetScores: resetScores, // Pass the resetScores callback
              ),
            ),
            Positioned(
              top: 50.0,
              right: 16.0,
              child: IconButton(
                onPressed: () async {
                  HapticFeedback.heavyImpact();
                  await Winner();
                  // String name = globals.winner;
                  // name = removeSpaces(name);
                  // globals.winner = name;
                  // String name2 = globals.looser;
                  // name = removeSpaces(name2);
                  // globals.looser = name;

                  await _launchURL();
                  print(globals.winner);
                },
                icon: const Icon(
                  CupertinoIcons.share_up,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: 100.0),
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              elevation: 0,
              onPressed: () {
                HapticFeedback.heavyImpact();
                resetScores();
              },
              // Use the resetScores callback
              child: const Icon(
                CupertinoIcons.arrow_clockwise,
                color: Colors.white,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required Key key,
    required this.title,
    required this.resetScores,
  }) : super(key: key);
  final String title;
  final VoidCallback resetScores; // Define the resetScores callback

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSwipeCounted1 = false;
  bool isSwipeCounted2 = false;

  @override
  void initState() {
    super.initState();
    isSwipeCounted1 = false;
    isSwipeCounted2 = false;
  }

  void subtractScore1() {
    if (!isSwipeCounted1) {
      globals.score1.value--;
      isSwipeCounted1 = true;
    }
  }

  void subtractScore2() {
    if (!isSwipeCounted2) {
      globals.score2.value--;
      isSwipeCounted2 = true;
    }
  }

  void subtractScore1Test() {
    globals.score1.value--;
  }

  void subtractScore2Test() {
    globals.score2.value--;
  }

  void resetSwipeCount1() {
    isSwipeCounted1 = false;
  }

  void resetSwipeCount2() {
    isSwipeCounted2 = false;
  }

  void changeTeamName1() {
    setState(() {
      globals.teamIndex1.value =
          (globals.teamIndex1.value + 1) % MyApp.teamNames.length;
      changeColor1(); // Call changeColor1 to update the color
    });
  }

  void changeTeamName1BBack() {
    setState(() {
      globals.teamIndex1.value =
          (globals.teamIndex1.value - 1) % MyApp.teamNames.length;
      changeColor1(); // Call changeColor1 to update the color
    });
  }

  void changeTeamName2() {
    setState(() {
      globals.teamIndex2.value =
          (globals.teamIndex2.value + 1) % MyApp.teamNames.length;
      changeColor2();
    });
  }

  void changeTeamName2Back() {
    setState(() {
      globals.teamIndex2.value =
          (globals.teamIndex2.value - 1) % MyApp.teamNames.length;
      changeColor2();
    });
  }

  void resetScores() {
    globals.score1.value = 0;
    globals.score2.value = 0;
  }

  String removeSpaces(String input) {
    return input.replaceAll(' ', '');
  }

  void changeColor1() {
    if (MyApp.teamNames[globals.teamIndex1.value] == 'Dvorkin Dodgers') {
      setState(() {
        globals.main1 = Colors.blue[700];
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] == 'Munkis Markes') {
      setState(() {
        globals.main1 = Colors.pink[300];
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] ==
        'Maharil Marchers') {
      setState(() {
        globals.main1 = Colors.blue[300];
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] == 'Nemenov Knights') {
      setState(() {
        globals.main1 = Colors.grey[300];
        .200;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] == 'Chain Chariots') {
      setState(() {
        globals.main1 = Colors.red;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] == 'Kesselman Kings') {
      setState(() {
        globals.main1 = Colors.green[300];
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] ==
        'Paritcher Poachers') {
      setState(() {
        globals.main1 = Colors.pink;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] == 'Rashbatz Riders') {
      setState(() {
        globals.main1 = Colors.yellow[300];
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] ==
        'Charitonov Chasers') {
      setState(() {
        globals.main1 = Colors.grey;
        .200;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] ==
        'Althoise Archers') {
      setState(() {
        globals.main1 = Colors.green;
        .900;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] == 'Pariz parkers') {
      setState(() {
        globals.main1 = Colors.brown;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] ==
        'Kletzker Crackers') {
      setState(() {
        globals.main1 = Colors.orange;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] ==
        'Futerfas Fighters') {
      setState(() {
        globals.main1 = Colors.purple;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] ==
        'Vilenkin Vacuums') {
      setState(() {
        globals.main1 = Colors.white;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] ==
        'Vilenkin Vacuums') {
      setState(() {
        globals.main1 = Colors.white;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] == 'Homler Hitchers') {
      setState(() {
        globals.main1 = Colors.red;
      });
    } else if (MyApp.teamNames[globals.teamIndex1.value] == 'Levitin Lakers') {
      setState(() {
        globals.main1 = Colors.yellow;
      });
    }
  }

  void changeColor2() {
    if (MyApp.teamNames[globals.teamIndex2.value] == 'Dvorkin Dodgers') {
      setState(() {
        globals.main2 = Colors.blue[700];
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] == 'Munkis Markes') {
      setState(() {
        globals.main2 = Colors.pink[300];
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] ==
        'Maharil Marchers') {
      setState(() {
        globals.main2 = Colors.blue[300];
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] == 'Nemenov Knights') {
      setState(() {
        globals.main2 = Colors.grey[300];
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] == 'Chain Chariots') {
      setState(() {
        globals.main2 = Colors.red;
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] == 'Kesselman Kings') {
      setState(() {
        globals.main2 = Colors.green[300];
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] ==
        'Paritcher Poachers') {
      setState(() {
        globals.main2 = Colors.pink;
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] == 'Rashbatz Riders') {
      setState(() {
        globals.main2 = Colors.yellow[300];
        .200;
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] ==
        'Charitonov Chasers') {
      setState(() {
        globals.main2 = Colors.grey;
        .200;
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] ==
        'Althoise Archers') {
      setState(() {
        globals.main2 = Colors.green;
        .900;
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] == 'Pariz parkers') {
      setState(() {
        globals.main2 = Colors.brown;
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] ==
        'Kletzker Crackers') {
      setState(() {
        globals.main2 = Colors.orange;
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] ==
        'Futerfas Fighters') {
      setState(() {
        globals.main2 = Colors.purple;
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] == 'Homler Hitchers') {
      setState(() {
        globals.main2 = Colors.red;
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] == 'Levitin Lakers') {
      setState(() {
        globals.main2 = Colors.yellow;
      });
    } else if (MyApp.teamNames[globals.teamIndex2.value] ==
        'Vilenkin Vacuums') {
      setState(() {
        globals.main2 = Colors.white;
      });
    }
  }

// globals.main1 = globals.Dvorkin;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.heavyImpact();
              globals.score1.value++;
            },
            onVerticalDragUpdate: (details) {
              if (details.delta.dy > 0) {
                // subtractScore1Test();
              }
            },
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy > 0) {
                HapticFeedback.heavyImpact();

                subtractScore1Test();
              }
            },
            child: ValueListenableBuilder<int>(
              valueListenable: globals.score1,
              builder: (context, score1, _) {
                return Container(
                  color: globals.main1 ?? Colors.grey[200],
                  width: 500,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            score1.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 100,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 90,
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            // onTap: () {
                            //   HapticFeedback.heavyImpact();
                            //   globals.score1.value++;
                            // },
                            // onHorizontalDragUpdate: (details) {
                            //   if (details.delta.dx < 0) {
                            //     // subtractScore1Test()
                            //   }
                            // },
                            onHorizontalDragEnd: (details) {
                              if (details.velocity.pixelsPerSecond.dx < 0) {
                                HapticFeedback.heavyImpact();
                                changeTeamName1();
                                changeColor1();
                                resetScores();
                              } else if (details.velocity.pixelsPerSecond.dx >
                                  0) {
                                HapticFeedback.heavyImpact();
                                changeTeamName1BBack();
                                changeColor1();
                                resetScores();
                              }
                            },
                            // child: GestureDetector(
                            //   onHorizontalDragUpdate: (details) {
                            //     if (details.delta.dy > 1) {
                            //       // subtractScore1Test();
                            //     }
                            //     HapticFeedback.heavyImpact();
                            //     changeTeamName1();
                            //     changeColor1();
                            //     resetScores();
                            //   },
                            child: Text(
                              MyApp.teamNames[globals.teamIndex1.value],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.heavyImpact();
              globals.score2.value++;
            },
            onVerticalDragUpdate: (details) {
              if (details.delta.dy > 0) {
                // subtractScore2();
              }
            },
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy > 0) {
                HapticFeedback.heavyImpact();
                subtractScore2Test();
              }
            },
            child: ValueListenableBuilder<int>(
              valueListenable: globals.score2,
              builder: (context, score2, _) {
                return Container(
                  color: globals.main2 ?? Colors.grey[200],
                  width: 500,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            score2.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 100,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 90,
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            // onTap: () {
                            //   HapticFeedback.heavyImpact();
                            //   globals.score1.value++;
                            // },
                            // onHorizontalDragUpdate: (details) {
                            //   if (details.delta.dx < 0) {
                            //     // subtractScore1Test()
                            //   }
                            // },
                            onHorizontalDragEnd: (details) {
                              if (details.velocity.pixelsPerSecond.dx < 0) {
                                HapticFeedback.heavyImpact();
                                changeTeamName2();
                                changeColor2();
                                resetScores();
                              } else if (details.velocity.pixelsPerSecond.dx >
                                  0) {
                                HapticFeedback.heavyImpact();
                                changeTeamName2Back();
                                changeColor2();
                                resetScores();
                              }
                            },
                            // child: GestureDetector(
                            //   onHorizontalDragUpdate: (details) {
                            //     if (details.delta.dy > 1) {
                            //       // subtractScore1Test();
                            //     }
                            //     HapticFeedback.heavyImpact();
                            //     changeTeamName1();
                            //     changeColor1();
                            //     resetScores();
                            //   },
                            child: Text(
                              MyApp.teamNames[globals.teamIndex2.value],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// Container(height: 80, color: Colors.black)

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: ''),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
