import 'package:flutter/material.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.stream, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 1.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
