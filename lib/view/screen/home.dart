import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../componet/all_categories.dart';
import '../../componet/all_spending.dart';
import '../../componet/categiores.dart';
import '../../componet/spending_componet.dart';
import '../../controller/bottom_navigation_bar_controller.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController controller = Get.put(NavigationController());
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.getIndex(index: index);
        },
        children: [
          spending(),
          All_spending(),
          All_categories(),
          categiores(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: Colors.greenAccent.shade100,
          selectedIndex: controller.bottomNavigationIndex.value,
          onDestinationSelected: (value) {
            controller.getIndex(index: value);
            controller.changePageView(index: value);
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.price_check_outlined),
              label: "All Spending",
            ),
            NavigationDestination(
              icon: Icon(Icons.attach_money),
              label: "Spending",
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long),
              label: "All categories",
            ),
            NavigationDestination(
              icon: Icon(Icons.category),
              label: "Categiores",
            ),
          ],
        );
      }),
    );
  }
}
