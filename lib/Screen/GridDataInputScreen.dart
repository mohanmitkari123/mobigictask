import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_technologies_task/Screen/SearchScreen.dart';
import 'package:mobigic_technologies_task/controller/GridInputController.dart';

class GridDataInputScreen extends StatelessWidget {
  final GridInputController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Enter Grid Data'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                      () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      int.parse(controller.rows.value),
                          (i) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          int.parse(controller.columns.value),
                              (j) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: TextField(
                                onChanged: (value) => controller.updateGridValue(i, j, value),
                                maxLength: 1,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: 'Enter letter',
                                  hintStyle: TextStyle(fontSize: 10)
                                  // border: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: controller.highlightData[i][j]
                                  //         ? Colors.green
                                  //         : Colors.grey,
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(SearchScreen());
                  },
                  child: Text('Search Text in Grid'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}