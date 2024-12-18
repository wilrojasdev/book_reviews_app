import 'package:book_reviews_app/services/shared_preference_services.dart';
import 'package:book_reviews_app/viewmodels/review_viewmodel.dart';
import 'package:book_reviews_app/views/books/widgets/rating_star.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddReview extends StatefulWidget {
  final String bookId;

  const AddReview({
    super.key,
    required this.bookId,
  });

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  double rating = 0;
  String comment = "";
  final TextEditingController commentController = TextEditingController();
  String? userEmail = '';
  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
  }

  bool isLoggedIn = false;
  String? userId;
  void _checkUserLoginStatus() async {
    userId = await SharedPreferenceService().getUserId();
    setState(() {
      isLoggedIn = userId != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewsViewModel>(
      builder: (context, reviewViewModel, child) {
        if (!isLoggedIn) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'To submit a review, you need to be logged in. Do you have an account? Log in now.',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }

        if (reviewViewModel.hasReview) {
          return const Text(
            'You have already submitted a review for this book.',
            style: TextStyle(color: Colors.green, fontSize: 16),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Add a Review',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            RatingStar(
              rating: rating,
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // Comment TextField
            TextField(
              controller: commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Your Comment',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  comment = value;
                });
              },
            ),
            const SizedBox(height: 16),
            reviewViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: rating > 0
                          ? () async {
                              await reviewViewModel.addReview(
                                userId!,
                                widget.bookId,
                                comment,
                                rating,
                              );
                            }
                          : null,
                      child: const Text('Submit Review'),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
