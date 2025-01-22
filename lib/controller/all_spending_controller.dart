import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Halper/dbhalper.dart';
import '../Modal/spending_model.dart';

class SpendingController extends GetxController {
  String? mode;
  DateTime? dateTime;

  int? spendingIndex;
  int categoryId = 0;

  void getSpendingModedata(String? value) {
    mode = value;

    update();
  }

  void getSpendingDate({required DateTime date}) {
    dateTime = date;

    update();
  }

  void getSpendingIndex({required int index, required int id}) {
    spendingIndex = index;
    categoryId = id;
    update();
  }

  void assignDefaultValue() {
    mode = dateTime = spendingIndex = null;

    update();
  }

  Future<void> addSpendingData({required SpendingModel model}) async {
    int? res = await DBHelper.dbHelper.insertSpendingdata(model: model);

    if (res != null) {
      Get.snackbar(
        "Inserted",
        "spending inserted....",
        backgroundColor: Colors.green.shade300,
      );
    } else {
      Get.snackbar(
        "Failed",
        "spending failed....",
        backgroundColor: Colors.red.shade300,
      );
    }
  }
}
