import 'package:flutter/material.dart';

class SuggestedItemValue extends StatelessWidget {
  const SuggestedItemValue({
    Key key,
    @required this.icon,
    @required this.rank,
    this.value,
    this.suffix,
    this.additional,
  }) : super(key: key);

  final Widget icon;
  final int rank;
  final int value;
  final String suffix;
  final String additional;

  static const fontSizes = [72.0, 48.0, 32.0, 24.0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8.0),
          Column(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$value',
                      style: TextStyle(fontSize: fontSizes[rank]),
                    ),
                    if (suffix != null)
                      TextSpan(text: suffix),
                  ],
                ),
              ),
              if (additional != null)
                  Text(additional),
            ],
          ),
        ],
      ),
    );
  }
}