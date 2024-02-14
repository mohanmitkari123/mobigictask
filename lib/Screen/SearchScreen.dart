
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_technologies_task/controller/GridInputController.dart';


class SearchScreen extends StatelessWidget {
  final GridInputController controller = Get.find();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search Text In Grid'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) => controller.searchText = value,
                decoration: InputDecoration(
                  hintText: 'Enter text to search',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.searchGrid()) {
                    Get.snackbar('Search Result', 'Text found in grid',backgroundColor: Colors.green,);
                  } else {
                    Get.snackbar('Search Result', 'Text not found in grid',backgroundColor: Colors.redAccent);
                  }
                },
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}