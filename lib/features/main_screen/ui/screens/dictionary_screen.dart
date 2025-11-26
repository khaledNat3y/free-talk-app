import 'package:flutter/material.dart';
import 'package:free_talk_app/core/helpers/spacing.dart';
import 'package:free_talk_app/features/main_screen/ui/widgets/custom_text_field.dart';

class DictionaryScreen extends StatelessWidget {
  final bool isDarkMode;
  const DictionaryScreen({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dictionary',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            // Search Bar
            CustomTextField(hintText: 'Search',onChanged: (value) {

            }, isDarkMode: isDarkMode,),
            verticalSpace(20),

            /// Results Display
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}