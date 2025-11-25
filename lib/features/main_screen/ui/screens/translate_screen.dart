import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';


class TranslateScreen extends StatelessWidget {
  const TranslateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Translate',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            // Input Field
            const CustomTextField(),
            const SizedBox(height: 20),

            // Sign Language Display
            // Container(
            //   height: 400,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             _buildSignImage(),
            //             _buildSignImage(),
            //             _buildSignImage(),
            //           ],
            //         ),
            //         const SizedBox(height: 20),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             _buildSignImage(),
            //             _buildSignImage(),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
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

