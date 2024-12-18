import 'package:book_reviews_app/models/review.dart';
import 'package:book_reviews_app/viewmodels/review_viewmodel.dart';
import 'package:flutter/material.dart';

void showDeleteDialog(
    BuildContext context, Review review, ReviewsViewModel reviewProvider) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Review'),
        content: const Text('Are you sure you want to delete this review?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              reviewProvider
                  .deleteReview(review.id, review.bookId)
                  .then((response) {
                if (!context.mounted) {
                  return false;
                }
                Navigator.of(context).pop();
              });
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
