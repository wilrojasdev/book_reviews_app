import 'package:book_reviews_app/viewmodels/navigation_viewmodel.dart';
import 'package:book_reviews_app/views/books/book_search_view.dart';
import 'package:book_reviews_app/views/books/books_general_view.dart';
import 'package:book_reviews_app/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  late ScrollController _scrollController;
  bool _isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!_isScrollingDown) {
        setState(() {
          _isScrollingDown = true;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrollingDown) {
        setState(() {
          _isScrollingDown = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationViewModel = Provider.of<NavigationViewModel>(context);

    final List<Widget> pages = [
      BooksGeneralView(
        scrollController: _scrollController,
      ),
      const BookSearchView(),
      const ProfileView()
    ];

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          navigationViewModel.routeName,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: const Color(0xff55b047),
      ),
      body: PersistentTabView(
        context,
        controller: navigationViewModel.persistentNavBarController,
        screens: pages,
        hideOnScrollSettings: HideOnScrollSettings(
          scrollControllers: [_scrollController],
        ),
        confineToSafeArea: true,
        resizeToAvoidBottomInset: true,
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.book),
            title: "Books",
            activeColorPrimary: const Color(0xff55b047),
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.search_sharp),
            title: "Search",
            activeColorPrimary: const Color(0xff55b047),
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.person_2),
            title: "Profile",
            activeColorPrimary: const Color(0xff55b047),
            inactiveColorPrimary: Colors.grey,
          ),
        ],
        onItemSelected: (int value) {
          navigationViewModel.setNameRoute(value);
        },
        navBarStyle: NavBarStyle.style3,
      ),
    );
  }
}
