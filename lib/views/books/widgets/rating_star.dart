import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class RatingStar extends StatelessWidget {
  const RatingStar({super.key, required this.rating, this.onChanged});

  final double rating;
  final dynamic Function(double)? onChanged;
  @override
  Widget build(BuildContext context) {
    return RatingStars(
      value: rating.toDouble(),
      onValueChanged: onChanged,
      starBuilder: (index, color) => Icon(
        Icons.star,
        color: color,
        size: 20,
      ),
      starCount: 5,
      starSize: 20,
      maxValue: 5,
      starSpacing: 2,
      maxValueVisibility: false,
      valueLabelVisibility: false,
      animationDuration: const Duration(milliseconds: 400),
      starOffColor: const Color(0xffe7e8ea),
      starColor: Colors.amber,
    );
  }
}
