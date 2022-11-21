import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  final String data;

  const CenteredText(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      key: key,
      child: Text(data),
    );
  }
}
