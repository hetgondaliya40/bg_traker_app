import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Halper/dbhalper.dart';
import '../Modal/category_modal.dart';

class catController extends GetxController {
  int? cat_index;
  Future<List<CategoryModel>>? allCat;

  void getCategoryImageIndex({required int index}) {
    cat_index = index;

    update();
  }

  Future addCat({required String name, required Uint8List image}) async {
    int? res = await DBHelper.dbHelper
        .insertdatainDATABASE(name: name, image: image, index: cat_index!);

    if (res == null) {
      Get.snackbar(
        "Failed",
        "$name insertion is failed... $res",
        backgroundColor: Colors.red.shade300,
      );
    } else {
      Get.snackbar(
        "Succesfully add ",
        "Chack it !!",
        backgroundColor: Colors.green.shade300,
      );
    }
  }

  void fatch() {
    allCat = DBHelper.dbHelper.fetchCategory();
  }
}
