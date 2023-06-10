import 'package:fh_wave/views/widgets/group_widgets/group_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/dark_mode_controller.dart';
import '../controllers/user_controller.dart';
import '../controllers/profile_screen_controller.dart';
import 'widgets/dark_mode_button.dart';
import 'widgets/timetables_button.dart';

final ProfileScreenController _controller = ProfileScreenController();
final UserController userController = UserController();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          toolbarHeight: 100,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _controller.title,
              style: TextStyle(
                  color: _controller.color,
                  fontSize: _controller.fontSize,
                  fontWeight: _controller.fontWeight),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DarkModeButton(),
              const SizedBox(height: 10),
              timetablesButton(),
              const SizedBox(
                height: 10,
              ),
              funcButton(context, "LogOut", Icons.logout, () {
                userController
                    .logOut()
                    .then((value) => Navigator.pushNamed(context, "/login"));
              })
            ],
          ),
        ),
        backgroundColor: controller.isDarkMode ? Colors.white12 : Colors.white,

        /// Hier schreibst du deine Code
        /// und bitte vergisst du noch MVC-Design-PatternContainer(),
      );
    });
  }
}
