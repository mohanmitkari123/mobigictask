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

  // void _searchGrid() {
  //   setState(() {
  //     matchedCells.clear();
  //     if (searchText.isEmpty) {
  //       setState(() {
  //         filteredGrid = widget.grid;
  //       });                             //Reset to original grid if search text is empty
  //     } else {
  //       filteredGrid = [];
  //       if (widget.grid.isNotEmpty && widget.grid[0].isNotEmpty) {
  //         filteredGrid = widget.grid.where((row) => row.any((cell) => cell.toLowerCase().contains(searchText.toLowerCase()))).toList();
  //         for (int i = 0; i < widget.grid.length; i++) {
  //           for (int j = 0; j < widget.grid[i].length; j++) {
  //             if (widget.grid[i][j].toLowerCase().contains(searchText.toLowerCase())) {
  //               matchedCells.add(Offset(i.toDouble(), j.toDouble()));
  //             }
  //           }
  //         }
  //       }
  //     }
  //   });
  // }

  void _searchGrid() {
    setState(() {
      matchedCells.clear();
      if (widget.grid.isNotEmpty && widget.grid[0].isNotEmpty) {
        for (int i = 0; i < widget.grid.length; i++) {
          for (int j = 0; j < widget.grid[i].length; j++) {
            if (_searchInDirections(i, j)) {
              matchedCells.add(Offset(i.toDouble(), j.toDouble()));
            }
          }
        }
      }
      if (matchedCells.isEmpty) {
        // Show a snackbar or dialog with a hint
        Get.snackbar('Message', 'The searched text was not found in the grid.',backgroundColor: Colors.redAccent);
      }
    });
  }

  bool _searchInDirections(int row, int col) {
    String text = searchText.toLowerCase();
    String cellText = widget.grid[row][col].toLowerCase();

    // Check east direction
    if (col + text.length <= widget.grid[0].length) {
      String eastText = '';
      for (int i = col; i < col + text.length; i++) {
        eastText += widget.grid[row][i].toLowerCase();
      }
      if (eastText == text) return true;
    }

    // Check south direction
    if (row + text.length <= widget.grid.length) {
      String southText = '';
      for (int i = row; i < row + text.length; i++) {
        southText += widget.grid[i][col].toLowerCase();
      }
      if (southText == text) return true;
    }

    // Check south-east direction
    if (row + text.length <= widget.grid.length && col + text.length <= widget.grid[0].length) {
      String southEastText = '';
      for (int i = 0; i < text.length; i++) {
        southEastText += widget.grid[row + i][col + i].toLowerCase();
      }
      if (southEastText == text) return true;
    }

    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              child: filteredGrid.isEmpty
                  ? Center(child: Text('No data available'))
                  : GridView.builder(
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
