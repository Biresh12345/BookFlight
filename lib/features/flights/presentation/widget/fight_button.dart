import 'package:flutter/material.dart';

class FightButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget label;
  final Color color;
  final TextStyle? style;
  const FightButton({
    super.key,
    this.onTap,
    required this.label,
    required this.color,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: label,
      ),
    );
  }
}
