import 'package:book_reviews_app/models/review.dart';
import 'package:book_reviews_app/utils/dialogs.dart';
import 'package:book_reviews_app/utils/formatters.dart';
import 'package:book_reviews_app/viewmodels/review_viewmodel.dart';
import 'package:book_reviews_app/views/books/widgets/rating_star.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
    required this.currentUserId,
    required this.reviewProvider,
  });

  final Review review;
  final String currentUserId;
  final ReviewsViewModel reviewProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.userName,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  formatDate(review.createdAt),
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
                if (review.userId == currentUserId)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDeleteDialog(context, review, reviewProvider);
                    },
                  ),
              ],
            ),
            RatingStar(rating: review.rating),
            const SizedBox(height: 4),
            Text(
              review.comment,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
