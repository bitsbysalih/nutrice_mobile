import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  final FaIcon icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      // width: double.infinity,
      width: 80,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF7F8FA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
