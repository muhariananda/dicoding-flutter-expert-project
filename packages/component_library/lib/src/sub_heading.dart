import 'package:component_library/src/common/costants.dart';
import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SubHeading({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kHeading6,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: const [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          )
        ],
      ),
    );
  }
}
