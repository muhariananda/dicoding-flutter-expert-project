import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';

class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 100,
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: kHeading5,
          ),
        ],
      ),
    );
  }
}
