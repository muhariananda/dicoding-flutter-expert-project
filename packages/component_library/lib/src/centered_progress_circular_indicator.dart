import 'package:flutter/material.dart';

class CenteredProgressCircularIndicator extends StatelessWidget {
  const CenteredProgressCircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
