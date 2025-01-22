import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Routes.getPages,
    );
  }
}
