import 'package:flutter/material.dart';

import '../Halper/dbhalper.dart';
import '../Modal/spending_model.dart';

class spending extends StatefulWidget {
  const spending({super.key});

  @override
  State<spending> createState() => _spendingState();
}

class _spendingState extends State<spending>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: DBHelper.dbHelper.fetchSpendingcat(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SpendingModel> spendingData = snapshot.data ?? [];

            return ListView.builder(
              itemCount: spendingData.length,
              itemBuilder: (context, index) {
                var data = SpendingModel(
                  id: spendingData[index].id,
                  desc: spendingData[index].desc,
                  amount: spendingData[index].amount,
                  mode: spendingData[index].mode,
                  date: spendingData[index].date,
                  categoryId: spendingData[index].categoryId,
                );
                return Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        spendingData[index].desc,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "₹ ${spendingData[index].amount}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "DATE : ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            data.date,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                        future: DBHelper.dbHelper
                            .fetchSingleCategory(id: data.categoryId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return (snapshot.data != null)
                                ? Text(
                                    snapshot.data!.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                : Container();
                          }
                          return Container();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          FutureBuilder(
                            future: DBHelper.dbHelper
                                .fetchSingleCategory(id: data.categoryId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return (snapshot.data != null)
                                    ? Image.memory(
                                        snapshot.data!.image,
                                        height: 50,
                                      )
                                    : Container();
                              }
                              return Container();
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ActionChip(
                            color: WidgetStateProperty.all(
                              (data.mode == 'online')
                                  ? Colors.green
                                  : Colors.yellow,
                            ),
                            label: Text(data.mode),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              )),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
