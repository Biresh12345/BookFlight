import 'package:flutter/material.dart';

class Inputtext extends StatelessWidget {
  final TextEditingController? controller;
  final String label;

  const Inputtext({super.key, this.controller, this.label = 'Name'});

  static const _cream = Color(0xFFFFFFF5);
  static const _navy = Color(0xFF0A0A5C);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: _navy, width: 1.2),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SizedBox(
            height: 61,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: _cream,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 24,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _cream,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
            ),
          ),
        ),
      ],
    );
  }
}
