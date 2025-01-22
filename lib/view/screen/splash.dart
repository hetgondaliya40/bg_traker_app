import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Routes/routes.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(Routes.home);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(""),
      ),
    );
  }
}
