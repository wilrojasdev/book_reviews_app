import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavigationViewModel extends ChangeNotifier {
  int _currentIndex = 1;
  PersistentTabController persistentNavBarController =
      PersistentTabController(initialIndex: 0);
  ScrollController scrollController = ScrollController();
  String _routeName = 'All Books';
  int get currentIndex => _currentIndex;

  bool _isScroll = false;

  bool get isScroll => _isScroll;
  String get routeName => _routeName;
  set routeName(String value) {
    routeName = value;
    notifyListeners();
  }

  set isScroll(bool value) {
    _isScroll = value;
    notifyListeners();
  }

  void setNameRoute(int index) {
    if (index == 0) {
      _routeName = 'Explore Books';
    } else if (index == 1) {
      _routeName = 'Search Books';
    } else if (index == 2) {
      _routeName = 'My Profile';
    }
    notifyListeners();
  }

  void updateIndex(int index, String routeName) {
    _currentIndex = index;
    _routeName = routeName;
    notifyListeners();
  }
}
