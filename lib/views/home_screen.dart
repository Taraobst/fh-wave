import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isLeftButtonSelected = true;
  PageController pageController = PageController(initialPage: 0);

  void toggleButtonSelection(bool isLeftSelected) {
    isLeftButtonSelected = isLeftSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: null,
      body: Stack(children: [
        // Blue Gradient Background
        Container(
          height: MediaQuery.of(context).size.height * 3 / 5,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(168, 207, 255, 1),
                Color.fromRGBO(250, 250, 250, 0)
              ],
            ),
          ),
        ),
        ListView(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    // fhwave logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/fhwave_logo_weiss.svg',
                          width: 70,
                        ),
                        Container(
                          child: ClipOval(
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              color: Colors.white,
                              child: IconButton(
                                icon: Icon(Icons.photo_camera_outlined),
                                color: Colors.black,
                                onPressed: () {},
                                // To maintain design consistency, please remember to eliminate effects of buttons
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 52,
                    ),
                    Text('Moin,\nMustermann!',
                        style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Helvetica Neue')),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Bist du voll motiviert?',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Helvetica Neue')),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLeftButtonSelected = true;
                            });
                            toggleButtonSelection(true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isLeftButtonSelected
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                width: 2.0,
                              ),
                            ),
                            width: 162.0,
                            height: 50.0,
                            child: Center(
                              child: Text(
                                'Meine Widgets',
                                style: TextStyle(
                                    color: isLeftButtonSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Helvetica Neue'),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLeftButtonSelected = false;
                            });
                            toggleButtonSelection(false);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isLeftButtonSelected
                                  ? Colors.white
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                width: 2.0,
                              ),
                            ),
                            width: 162.0,
                            height: 50.0,
                            child: Center(
                              child: Text(
                                'Quicklinks',
                                style: TextStyle(
                                    color: isLeftButtonSelected
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Helvetica Neue'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // The widgets will be presented
                    Visibility(
                      visible: isLeftButtonSelected,
                      child: Text("Left button selected!"),
                    ),
                    // The quick links will be presented
                    Visibility(
                      visible: !isLeftButtonSelected,
                      child: Text("Right button selected!"),
                    ),
                  ],
                ))
          ],
        )
      ]),
    );
  }
}
