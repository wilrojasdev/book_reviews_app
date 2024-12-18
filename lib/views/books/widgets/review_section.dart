import 'package:book_reviews_app/viewmodels/review_viewmodel.dart';
import 'package:book_reviews_app/views/books/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewSection extends StatefulWidget {
  final ReviewsViewModel reviewProvider;
  final String userName;

  const ReviewSection(
      {super.key, required this.reviewProvider, required this.userName, r});

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewsViewModel>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        reviewProvider.bookReviews.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviewProvider.bookReviews.length,
                itemBuilder: (context, index) {
                  final review = reviewProvider.bookReviews[index];
                  return ReviewCard(
                      review: review,
                      currentUserId: reviewProvider.currentUser,
                      reviewProvider: reviewProvider);
                },
              )
            : const Text(
                'No reviews yet',
                style: TextStyle(color: Colors.grey),
              ),
      ],
    );
  }
}
