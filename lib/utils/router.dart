import 'package:book_reviews_app/views/auth/login_view.dart';
import 'package:book_reviews_app/views/auth/register_view.dart';
import 'package:book_reviews_app/views/books/book_detail_view.dart';
import 'package:book_reviews_app/views/books/books_category_view.dart';
import 'package:book_reviews_app/views/home/navigation_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(initialLocation: '/navigation_view', routes: [
  GoRoute(
    path: '/navigation_view',
    builder: (context, state) => NavigationView(),
  ),
  GoRoute(
    path: '/books_category',
    builder: (context, state) => BooksCategoryView(
      category: state.extra as String,
    ),
  ),
  GoRoute(
    path: '/book_detail',
    builder: (context, state) => BookDetailView(
      bookId: state.extra as String,
    ),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => LoginView(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => RegisterView(),
  ),
]);
