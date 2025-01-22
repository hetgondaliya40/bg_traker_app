import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Modal/category_modal.dart';
import '../controller/cat_controller.dart';

class All_categories extends StatelessWidget {
  const All_categories({super.key});

  @override
  Widget build(BuildContext context) {
    catController controller = Get.put(catController());
    controller.fatch();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          GetBuilder<catController>(builder: (context) {
            return FutureBuilder(
              future: controller.allCat,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("ERROR ${snapshot.error} "),
                  );
                } else if (snapshot.hasData) {
                  List<CategoryModel> alldata = snapshot.data ?? [];
                  return (alldata.isNotEmpty)
                      ? ListView.builder(
                          itemCount: alldata.length,
                          itemBuilder: (context, index) {
                            CategoryModel data = CategoryModel(
                              id: alldata[index].id,
                              name: alldata[index].name,
                              image: alldata[index].image,
                              index: alldata[index].index,
                            );
                            log("DATA : $data");
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: MemoryImage(data.image),
                                ),
                                title: Text(data.name),
                              ),
                            );
                          },
                        )
                      : Text("not found ..");
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          })
        ],
      ),
    );
  }
}
