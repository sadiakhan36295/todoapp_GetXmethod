import 'package:flutter/material.dart';
import '../custom_text/custom_text.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final String description;

  const CustomContainer({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200], // ✅ Light grey background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 22), // Optional icon
          const SizedBox(height: 8),

          CustomText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black, // ✅ Title text black
            bottom: 6,
          ),

          CustomText(
            text: description,
            fontSize: 14,
            color: Colors.black, // ✅ Description text black
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
