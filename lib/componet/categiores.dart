import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/cat_controller.dart';

TextEditingController inputcontroller = TextEditingController();

List<String> categoryImages = [
  "assets/images/bill.png",
  "assets/images/cash.png",
  "assets/images/communication.png",
  "assets/images/deposit.png",
  "assets/images/food.png",
  "assets/images/gift.png",
  "assets/images/health.png",
  "assets/images/movie.png",
  "assets/images/rupee.png",
  "assets/images/salary.png",
  "assets/images/shopping.png",
  "assets/images/transport.png",
  "assets/images/wallet.png",
  "assets/images/withdraw.png",
  "assets/images/other.png",
];

class categiores extends StatelessWidget {
  const categiores({super.key});

  @override
  Widget build(BuildContext context) {
    catController controller = Get.put(catController());
    GlobalKey key = GlobalKey();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: inputcontroller,
                validator: (value) => value!.isEmpty ? "Required..." : null,
                decoration: InputDecoration(
                  hintText: "Choss your categories...",
                  labelText: "Categories",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 5,
                child: GridView.builder(
                  itemCount: categoryImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) =>
                      GetBuilder<catController>(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        controller.getCategoryImageIndex(index: index);
                        log(categoryImages[index].toString());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (index == controller.cat_index)
                                ? Colors.greenAccent
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(
                              categoryImages[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (inputcontroller.text.isNotEmpty && controller.cat_index != null) {
            String name = inputcontroller.text;
            int catIndex = controller.cat_index ?? 0;
            String imagePath = categoryImages[catIndex];

            ByteData byteData = await rootBundle.load(imagePath);
            Uint8List image = byteData.buffer.asUint8List();

            await controller.addCat(name: name, image: image).then(
              (value) {
                inputcontroller.clear();
              },
            );
          } else {
            Get.snackbar(
              "Required",
              "All fields are required...",
              backgroundColor: Colors.redAccent,
            );
          }
        },
        icon: Icon(Icons.category),
        label: Text("Add Categories"),
      ),
    );
  }
}
