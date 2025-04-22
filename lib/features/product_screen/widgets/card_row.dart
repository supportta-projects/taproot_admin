import 'package:flutter/material.dart';

class CardRow extends StatelessWidget {
  final String prefixText;
  final String suffixText;
  const CardRow({
    required this.prefixText,
    required this.suffixText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(prefixText),
        Spacer(),
        Expanded(
          child: Text(
            textAlign: TextAlign.right,
            suffixText,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
