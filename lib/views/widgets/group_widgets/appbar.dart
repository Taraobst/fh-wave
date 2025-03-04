import 'package:flutter/material.dart';

//ignore: must_be_immutable
class TransparentAppbar extends StatelessWidget {
  TransparentAppbar({super.key, required this.heading, required this.func});

  VoidCallback func;
  String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            const SizedBox(
              width: 22,
            ),
            GestureDetector(
              child: const Icon(Icons.arrow_back_ios_new_rounded),
              onTap: () {
                func();

                //   if (routeName == "/home" || routeName == "/group") {
                //     Navigator.pop(context);
                //   } else {
                //     Navigator.pushNamed(context, routeName);
                //   }
              },
            ),
            const SizedBox(width: 12),
            Text(
              heading,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ],
    );
  }
}
