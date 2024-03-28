import 'package:flutter/material.dart';

class PageState with ChangeNotifier {
  // Variables to store your state data (e.g., selected tab index, form data)
  int _selectedTabIndex = 1;

  int get selectedTabIndex => _selectedTabIndex;

  void setSelectedIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners(); // Notify listeners when state changes
  }
}
