import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Halper/dbhalper.dart';
import '../Modal/category_modal.dart';
import '../Modal/spending_model.dart';
import '../controller/spending_controller.dart';

TextEditingController descController = TextEditingController();
TextEditingController amountController = TextEditingController();
GlobalKey<FormState> spendingKey = GlobalKey<FormState>();

class All_spending extends StatelessWidget {
  const All_spending({super.key});

  // Add a form key for validation
  @override
  Widget build(BuildContext context) {
    spending_controller controller_spending = Get.put(spending_controller());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: spendingKey,
          child: Column(
            children: [
              TextFormField(
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: "Description",
                  labelText: "Description",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(12)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(12)),
                ),
                controller: descController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "₹000",
                  labelText: "Amount",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(12)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(12)),
                ),
                controller: amountController,
                validator: (val) => val!.isEmpty ? "required amount...." : null,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  DropdownButton(
                    value: controller_spending.mode,
                    hint: const Text("Select"),
                    items: const [
                      DropdownMenuItem(
                        value: "online",
                        child: Text("Online"),
                      ),
                      DropdownMenuItem(
                        value: "offline",
                        child: Text("Offline"),
                      ),
                    ],
                    onChanged: controller_spending.getSpendingMode,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2026),
                      );

                      if (date != null) {
                        controller_spending.getSpendingDate(date: date);
                      }
                    },
                    icon: const Icon(Icons.date_range),
                  ),
                  if (controller_spending.dateTime != null)
                    Text(
                      "${controller_spending.dateTime?.day}/${controller_spending.dateTime?.month}/${controller_spending.dateTime?.year}",
                    )
                  else
                    const Text("DD/MM/YYYY"),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                    future: DBHelper.dbHelper.fetchCategory(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        List<CategoryModel> category = snapShot.data ?? [];

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: category.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              controller_spending.getSpendingIndex(
                                index: index,
                                id: category[index].id ?? 0,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: (index ==
                                          controller_spending.spendingIndex)
                                      ? Colors.grey
                                      : Colors.transparent,
                                ),
                                image: DecorationImage(
                                  image: MemoryImage(category[index].image),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  if (spendingKey.currentState!.validate() &&
                      controller_spending.mode != null &&
                      controller_spending.dateTime != null &&
                      controller_spending.spendingIndex != null) {
                    controller_spending.addSpendingData(
                      model: SpendingModel(
                        id: 0,
                        desc: descController.text,
                        amount: num.parse(amountController.text),
                        mode: controller_spending.mode!,
                        date:
                            "${controller_spending.dateTime?.day}/${controller_spending.dateTime?.month}/${controller_spending.dateTime?.year}",
                        categoryId: controller_spending.categoryId,
                      ),
                    );
                    descController.clear();
                    amountController.clear();
                    controller_spending.assignDefaultValue();
                  } else {
                    Get.snackbar(
                      "Required",
                      "all field are required....",
                      backgroundColor: Colors.red.shade300,
                    );
                  }
                },
                label: const Text("Add Spending"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
