import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/molecules/rating_bar/rating_bar.dart';
import 'package:flutter/material.dart';

import 'rating_header.dart';

class RatingCommentCard extends StatefulWidget {
  const RatingCommentCard({super.key});

  @override
  State<RatingCommentCard> createState() => _RatingCommentCardState();
}

class _RatingCommentCardState extends State<RatingCommentCard> {
  double rate = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Column(
        children: [
          RatingHeader(title: 'Tell us what you think'),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              spacing: 8,
              children: [
                AppRatingBar(
                  rate: rate,
                  onPressed: (value) {
                    setState(() {
                      rate = value;
                    });
                  },
                  size: RatingCellSize.medium,
                  type: RatingCellType.favorite,
                ),
                AppTextField(
                  isFilled: false,
                  hint: 'Share your thoughts here...',
                  maxLines: 4,
                ),
              ],
            ),
          ),

          AppDivider(),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Send',
                    color: SemanticColor.neutral,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
