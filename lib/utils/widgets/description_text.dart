import 'package:flutter/material.dart';
import 'package:weather_app/utils/dimensions.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.small),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
