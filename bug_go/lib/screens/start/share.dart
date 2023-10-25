import 'package:bus_go/screens/start/login.dart';
import 'package:bus_go/screens/start/signup.dart';
import 'package:flutter/material.dart';

class Share extends StatefulWidget {
  const Share({super.key});

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Login(
              controller: controller,
            );
          } else {
            return SignUp(
              controller: controller,
            );
          }
        },
      ),
    );
  }
}
