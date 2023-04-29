import 'package:flutter/material.dart';

class ColorBox extends StatelessWidget {
  final Function() onTap;
  final Color color;
  final bool isActive;
  const ColorBox({
    super.key,
    required this.color,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isActive ? 50 : 40,
      height: isActive ? 50 : 40,
      child: Material(
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: isActive ? 2 : 0.1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        color: color,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
        ),
      ),
    );
  }
}
