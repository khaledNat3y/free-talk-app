import 'package:flutter/material.dart';
import 'package:free_talk_app/core/helpers/spacing.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage('assets/images/Rectangle 17.png')),

        verticalSpace(40),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              verticalSpace(30),
              Text(description,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),

        const Spacer(),
      ],
    );
  }
}
