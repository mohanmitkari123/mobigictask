import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screen/GridInputScreen.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         centerTitle: true,
        title: Text('Grid Search App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => GridInputScreen());
          },
          child: Text('Start'),
        ),
      ),
    );
  }
}