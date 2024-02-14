import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_technologies_task/Screen/GridDataInputScreen.dart';
import 'package:mobigic_technologies_task/controller/GridInputController.dart';

class GridInputScreen extends StatelessWidget {
  final GridInputController controller = Get.put(GridInputController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Enter Grid Size'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter the number of rows:'),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter rows',
                ),
                onChanged: (value) => controller.setRows(value),
              ),
              SizedBox(height: 20),
              Text('Enter the number of columns:'),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter columns',
                ),
                onChanged: (value) => controller.setColumns(value),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.createGrid();
                  Get.to(GridDataInputScreen());
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}