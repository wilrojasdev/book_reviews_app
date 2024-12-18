import 'package:book_reviews_app/firebase_options.dart';
import 'package:book_reviews_app/utils/router.dart';
import 'package:book_reviews_app/viewmodels/auth_viewmodel.dart';
import 'package:book_reviews_app/viewmodels/books_viewmodel.dart';
import 'package:book_reviews_app/viewmodels/navigation_viewmodel.dart';
import 'package:book_reviews_app/viewmodels/profile_viewmodel.dart';
import 'package:book_reviews_app/viewmodels/review_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BooksViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
