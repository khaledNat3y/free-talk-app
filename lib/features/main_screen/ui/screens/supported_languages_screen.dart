import 'package:flutter/material.dart';
import 'package:free_talk_app/core/helpers/app_assets.dart';
import 'package:free_talk_app/core/helpers/extensions.dart';
import 'package:free_talk_app/core/helpers/spacing.dart';
import 'package:free_talk_app/core/theming/app_colors.dart';
import 'package:free_talk_app/core/widgets/custom_back_butotn.dart';

class SupportedLanguagesScreen extends StatelessWidget {
  final bool? isDarkMode;

  const SupportedLanguagesScreen({
    super.key,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Supported\nLanguages',
                    softWrap: true,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  CustomBackButton(isDarkMode: isDarkMode!,),
                ],
              ),
              verticalSpace(10),
              Text(
                'You can search for gesture signs in these Languages',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              verticalSpace(20),
              /// French Card
              _buildLanguageCard(
                flagUrl: AppAssets.frenchFlag,
                description: 'Access lessons and full dictionary for\nFrench sign language (LSF) ',
                color: AppColors.french,
              ),
              const SizedBox(height: 15),
        
              /// American Card
              _buildLanguageCard(
                flagUrl: AppAssets.americanFlag,
                description: 'Explore comprehensive English sign\nlanguage (ASL) Dictionary and lessons.',
                color: AppColors.american,
              ),
              const SizedBox(height: 15),
        
              /// Egypt Card
              _buildLanguageCard(
                flagUrl: AppAssets.egyptFlag,
                description: 'Discover resources for Amer sign\nlanguage tailored for native speakers.',
                color: AppColors.egyptian,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required String flagUrl,
    required String description,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(flagUrl,),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          horizontalSpace(20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}