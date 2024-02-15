import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_technologies_task/Screen/GridInputScreen.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => GridInputScreen()); // Replace with your main screen
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/mobigic.jpg'), // Replace with your splash screen image path
      ),
    );
  }
}
