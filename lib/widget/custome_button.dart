import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class CustomButton extends StatelessWidget {
  final ButtonType buttonType;
  final String text;
  final Function() onTap;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.buttonType = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(5),
      color: buttonType == ButtonType.primary ? Colors.black : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        splashColor:
            buttonType == ButtonType.primary ? Colors.white : Colors.black,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: buttonType == ButtonType.primary
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
