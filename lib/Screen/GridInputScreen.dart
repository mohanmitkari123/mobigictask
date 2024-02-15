import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_technologies_task/Screen/AlphabetEntryScreen.dart';



class GridInputScreen extends StatefulWidget {
  @override
  _GridInputScreenState createState() => _GridInputScreenState();
}

class _GridInputScreenState extends State<GridInputScreen> {
  final TextEditingController mController = TextEditingController();
  final TextEditingController nController = TextEditingController();

  void _onSubmit() {
    int m = int.tryParse(mController.text) ?? 0;
    int n = int.tryParse(nController.text) ?? 0;

    if (m > 0 && n > 0) {
      Get.to(() => AlphabetEntryScreen(rows: m, columns: n));
    } else {
      Get.snackbar('Error', 'Please enter valid values for m and n');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Enter Grid Size'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: mController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter number of rows (m)',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter number of columns (n)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onSubmit,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
