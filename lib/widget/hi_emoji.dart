import 'package:flutter/material.dart';

class HiEmoji extends StatelessWidget {
  const HiEmoji({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "🙋🏻‍♀️",
        style: TextStyle(fontSize: 44),
      ),
    );
  }
}
