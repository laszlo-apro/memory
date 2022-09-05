import 'package:flutter/material.dart';

class MemoryCardLabel extends StatelessWidget {
  const MemoryCardLabel({
    Key? key,
    required this.text,
    this.leftPadding = 0.0,
    this.rightPadding = 0.0,
  }) : super(key: key);

  final String text;
  final double leftPadding;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: leftPadding,
        right: rightPadding,
      ),
      color: Colors.grey[700]!.withOpacity(0.6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Permanent Marker',
          fontSize: 11.0,
        ),
      ),
    );
  }
}
