import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckedInScreen extends StatefulWidget {
  Map<String, dynamic> provider;

  CheckedInScreen({Key? key, required this.provider}) : super(key: key);

  @override
  _CheckedInScreenState createState() => _CheckedInScreenState();
}

class _CheckedInScreenState extends State<CheckedInScreen> {
  DateTime checkInTime = DateTime.now();
  Duration checkInDuration = Duration(seconds: 0);

  late Timer _timer;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          checkInDuration = DateTime.now().difference(checkInTime);
        });
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6ABC88),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("You're checked in"),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/profile_picture.png'),
                              backgroundColor: Colors.transparent,
                              radius: 70,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: Icon(
                                  Icons.check,
                                  color: const Color(0xFF6ABC88),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Checked in ${checkInDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(checkInDuration.inSeconds.remainder(60)).toString().padLeft(2, '0')} minutes ago"),
                        ),
                        Text("Nico Kuhn"),
                        Text("M Membership No. 707727651",
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints.expand(height: 170),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/fitness.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(widget.provider['activity']!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      DateFormat('dd. MMM kk:mm')
                                          .format(checkInTime),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.grey,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          widget.provider['Title']!,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.label,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(widget.provider['activity']!,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Divider(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  backgroundColor: Colors.transparent,
                                  side:
                                      BorderSide(color: Colors.blue, width: 1),
                                ),
                                onPressed: () {},
                                child: Text("Share this check-in",
                                    style: TextStyle(fontSize: 15))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
