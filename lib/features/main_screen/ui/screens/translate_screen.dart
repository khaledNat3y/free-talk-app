import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';


class TranslateScreen extends StatelessWidget {
  final bool isDarkMode;
  const TranslateScreen({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Translate',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          // Input Field
          CustomTextField(hintText: 'Search',isDarkMode: isDarkMode,),
          const SizedBox(height: 20),

          // Sign Language Display
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
    );
  }

  // Widget _buildSignImage() {
  //   return Container(
  //     width: 80,
  //     height: 80,
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey.shade300),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: const Icon(Icons.front_hand, size: 40, color: Colors.grey),
  //   );
  // }
}

