import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_technologies_task/Screen/GridDisplayScreen.dart';



class AlphabetEntryScreen extends StatefulWidget {
  final int rows;
  final int columns;

  AlphabetEntryScreen({required this.rows, required this.columns});

  @override
  _AlphabetEntryScreenState createState() => _AlphabetEntryScreenState();
}

class _AlphabetEntryScreenState extends State<AlphabetEntryScreen> {
  List<List<String>> grid = [];

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    grid = List.generate(widget.rows, (_) => List.filled(widget.columns, ''));
  }

  void _onSubmit() {
    // Check if all positions in the grid are filled with alphabetic characters
    bool isValidGrid = grid.every((row) => row.every((cell) => _isAlphabet(cell)));

    if (isValidGrid) {
      // Navigate to the screen where the grid will be displayed
      Get.to(() => GridDisplayScreen(grid: grid));
    } else {
      _showErrorSnackbar();
    }
  }

  void _showErrorSnackbar() {
    Get.snackbar('Error', 'Please fill all positions in the grid with alphabetic characters');
  }
  bool _isAlphabet(String value) {
    return RegExp(r'^[a-zA-Z]$').hasMatch(value);
  }
  // void _showErrorSnackbar() {
  //   Get.snackbar('Error', 'Please enter alphabetic characters only');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Enter Alphabets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.columns,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: widget.rows * widget.columns,
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ widget.columns;
                  int col = index % widget.columns;
                  return TextField(
                    maxLength: 1, // Limit to single alphabet
                    onChanged: (value) {
                      if (_isAlphabet(value)) {
                        setState(() {
                          grid[row][col] = value; // Convert to uppercase
                        });
                      }else{
                        _showErrorSnackbar();
                      }
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      counterText: '', // Hide character count
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onSubmit,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
