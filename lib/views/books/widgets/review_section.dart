import 'package:book_reviews_app/viewmodels/review_viewmodel.dart';
import 'package:book_reviews_app/views/books/widgets/review_card.dart';
import 'package:flutter/material.dart';

class ReviewSection extends StatelessWidget {
  final ReviewsViewModel reviewProvider;
  final String userName;
  final String currentUserId;
  const ReviewSection(
      {super.key,
      required this.reviewProvider,
      required this.userName,
      required this.currentUserId});

  @override
  Widget build(BuildContext context) {
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
                      userName: userName,
                      review: review,
                      currentUserId: currentUserId,
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
