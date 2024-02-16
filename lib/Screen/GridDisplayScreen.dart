import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridDisplayScreen extends StatefulWidget {
  final List<List<String>> grid;

  GridDisplayScreen({required this.grid});

  @override
  _GridDisplayScreenState createState() => _GridDisplayScreenState();
}

class _GridDisplayScreenState extends State<GridDisplayScreen> {
  late List<List<String>> filteredGrid;
  String searchText = '';
  List<Offset> matchedCells = [];


  @override
  void initState() {
    super.initState();
    filteredGrid = widget.grid;
  }

  void _searchGrid() {
    setState(() {
      matchedCells.clear();
      List<String> searchList = searchText.toUpperCase().split('');
      bool foundMatch = false;
      for (int i = 0; i < widget.grid.length; i++) {
        for (int j = 0; j < widget.grid[i].length; j++) {
          if (_checkForText(i, j, widget.grid, searchList)) {
            matchedCells.add(Offset(i.toDouble(), j.toDouble()));
            foundMatch = true;
          }
        }
      }
      if (!foundMatch) {
        // Show a snackbar indicating no matches were found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No matches found'),
          ),
        );
      }
    });
  }

  bool _checkForText(int row, int col, List<List<String>> grid, List<String> searchList) {
    bool foundMatch = false;
    for (String searchChar in searchList) {
      if (row < grid.length && col < grid[row].length && grid[row][col].toUpperCase() == searchChar) {
        matchedCells.add(Offset(row.toDouble(), col.toDouble()));
        foundMatch = true;
      }
    }
    return foundMatch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Display'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  onPressed: () => _searchGrid(),
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: filteredGrid.isNotEmpty ? filteredGrid[0].length : 0,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: filteredGrid.length * (filteredGrid.isNotEmpty ? filteredGrid[0].length : 0),
                itemBuilder: (context, index) {
                  int row = index ~/ (filteredGrid.isNotEmpty ? filteredGrid[0].length : 0);
                  int col = index % (filteredGrid.isNotEmpty ? filteredGrid[0].length : 0);
                  bool isMatched = matchedCells.contains(Offset(row.toDouble(), col.toDouble()));
                  return Container(
                    color: isMatched ? Colors.yellow : Colors.grey[300],
                    child: Center(
                      child: Text(
                        filteredGrid[row][col],
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
