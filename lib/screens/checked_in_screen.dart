import 'dart:async';
import 'dart:math';

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
  late ValueNotifier<Duration> checkInDurationNotifier;

  late Timer _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        checkInDurationNotifier.value = DateTime.now().difference(checkInTime);
      },
    );
  }

  @override
  void initState() {
    checkInDurationNotifier = ValueNotifier(Duration.zero);
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showGreenDialog(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    checkInDurationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBE9FD),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/check-in-background.png',
            ),
          ),
          SafeArea(
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /*Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("You're checked in"),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: BoxConstraints.expand(height: 120),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xFF191E24),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  /*Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/fitness.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),*/
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(),
                                        Text(widget.provider['activity']!,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        /*Text(
                                          DateFormat('dd. MMM kk:mm')
                                              .format(checkInTime),
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.black),
                                        ),*/
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            /*Icon(
                                              Icons.location_on,
                                              color: Colors.grey,
                                              size: 12,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),*/
                                            Text(
                                              widget.provider['Title']!,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline,
                                              size: 16,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text("Checked in",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green)),
                                          ],
                                        ),
                                        SizedBox(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              /*Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Divider(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),*/
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 4, 12, 12),
                                child: SizedBox(
                                  width: 90,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.all(20),
                                        foregroundColor: Colors.blue,
                                        backgroundColor: Colors.transparent,
                                        side: BorderSide(
                                            color: Colors.lightBlue, width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8), // Custom border radius
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text("View",
                                          style: TextStyle(fontSize: 15))),
                                ),
                              ),
                            ],
                          ),
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.blueGrey,
        backgroundColor: Color(0xFF191E24), // Hex color for the background
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop),
            label: 'Venues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Check-In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
      ),
    );
  }

  void _showGreenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF058461), // Green background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Positioned(
                      top: -140,
                      right: -70,
                      bottom: 0,
                      child: DashedCircleAvatar(
                        imagePath: 'assets/images/profile_picture.png',
                      ),
                    ),
                    Positioned(
                      top: -30,
                      right: -70,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(
                          Icons.check,
                          color: const Color(0xFF058461),
                        ),
                      ),
                    ),
                    // Top-left icon
                    Positioned(
                      top: -10,
                      left: 100,
                      child: IconButton(
                        icon: Icon(Icons.ios_share, color: Colors.white),
                        onPressed: () {
                          // Handle top-left icon action
                        },
                      ),
                    ),
                    // Top-right icon
                    Positioned(
                      top: -10,
                      right: 100,
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ),
                  ],
                ),
                Text(
                  "Check-in successful",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Nico Kuhn",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                Text(
                  "707727651",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(widget.provider["activity"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                Text(widget.provider["Title"]),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Checked-in at",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(DateFormat('MMM d, HH:mm').format(checkInTime),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 20,
                            ),
                            ValueListenableBuilder<Duration>(
                              valueListenable: checkInDurationNotifier,
                              builder: (context, duration, child) {
                                return Text(
                                  " ${duration.inMinutes.remainder(60).toString().padLeft(1, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dotRadius;
  final double gapBetweenElements;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 3,
    this.dashLength = 15.0,
    this.dotRadius = 1.0,
    this.gapBetweenElements = 12.0, // Padding between elements
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final double circumference = 2 * pi * radius;
    final double segmentLength =
        dashLength + (2 * dotRadius * 2) + (2 * gapBetweenElements);
    final int segmentCount = (circumference / segmentLength).floor();

    for (int i = 0; i < segmentCount; i++) {
      // Calculate start angle for each segment
      final double startAngle = i * segmentLength / radius;

      // Draw dash
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        dashLength / radius,
        false,
        paint,
      );

      // Draw first dot
      final double firstDotAngle =
          startAngle + (dashLength / radius) + (gapBetweenElements / radius);
      final Offset firstDotOffset = Offset(
        size.width / 2 + radius * cos(firstDotAngle),
        size.height / 2 + radius * sin(firstDotAngle),
      );
      canvas.drawCircle(firstDotOffset, dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DashedCircleAvatar extends StatelessWidget {
  final String imagePath;

  DashedCircleAvatar({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(160, 160), // Adjust size as needed
          painter: DashedCirclePainter(
            color: Colors.white,
          ),
        ),
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 70, // Adjust radius to fit inside the dashed border
        ),
      ],
    );
  }
}
