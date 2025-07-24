import 'package:flutter/material.dart';
import 'package:practice_todoapp/gen/assets.gen.dart';

class CustomIconContainer extends StatelessWidget {
  final AssetGenImage icon; // Background image
  final double size;
  final bool isSelected;

  const CustomIconContainer({
    super.key,
    required this.icon,
    this.size = 24,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 18,
      height: size + 18,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.shade100 : Colors.grey.shade200,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.green : Colors.transparent,
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background image
          icon.image(
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),

          // Centered overlay image (addtaskicon)
          Assets.images.addtaskicon.image(
            width: 22,
            height: 22,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
