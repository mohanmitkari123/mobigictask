import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridInputController extends GetxController {
  final rows = ''.obs;
  final columns = ''.obs;
  final List<List<String>> gridData = <List<String>>[].obs;
  String searchText = '';
  final List<List<bool>> highlightData = <List<bool>>[].obs;

  void setRows(String value) => rows.value = value;
  void setColumns(String value) => columns.value = value;

  void createGrid() {
    int rowCount = int.parse(rows.value);
    int columnCount = int.parse(columns.value);
    gridData.clear();
    for (int i = 0; i < rowCount; i++) {
      List<String> row = [];
      for (int j = 0; j < columnCount; j++) {
        row.add('');
      }
      gridData.add(row);
    }
    highlightData.clear();
    for (int i = 0; i < rowCount; i++) {
      List<bool> row = List.filled(columnCount, false);
      highlightData.add(row);
    }
  }

  void updateGridValue(int rowIndex, int colIndex, String value) {
    gridData[rowIndex][colIndex] = value;
  }

  bool searchGrid() {
    bool found = false;
    for (int i = 0; i < gridData.length; i++) {
      for (int j = 0; j < gridData[i].length; j++) {
        if (searchEast(i, j) || searchSouth(i, j) || searchSouthEast(i, j)) {
          found = true;
        }
      }
    }
    return found;
  }

  bool searchEast(int row, int col) {
    String searchWord = searchText.toLowerCase();
    int len = searchWord.length;
    if (col + len > gridData[row].length) {
      return false;
    }
    String word = '';
    for (int i = col; i < col + len; i++) {
      word += gridData[row][i].toLowerCase();
    }
    if (word == searchWord) {
      for (int i = col; i < col + len; i++) {
        highlightData[row][i] = true;
      }
      return true;
    }
    return false;
  }

  bool searchSouth(int row, int col) {
    String searchWord = searchText.toLowerCase();
    int len = searchWord.length;
    if (row + len > gridData.length) {
      return false;
    }
    String word = '';
    for (int i = row; i < row + len; i++) {
      word += gridData[i][col].toLowerCase();
    }
    if (word == searchWord) {
      for (int i = row; i < row + len; i++) {
        highlightData[i][col] = true;
      }
      return true;
    }
    return false;
  }

  bool searchSouthEast(int row, int col) {
    String searchWord = searchText.toLowerCase();
    int len = searchWord.length;
    if (row + len > gridData.length || col + len > gridData[row].length) {
      return false;
    }
    String word = '';
    for (int i = 0; i < len; i++) {
      word += gridData[row + i][col + i].toLowerCase();
    }
    if (word == searchWord) {
      for (int i = 0; i < len; i++) {
        highlightData[row + i][col + i] = true;
      }
      return true;
    }
    return false;
  }

}