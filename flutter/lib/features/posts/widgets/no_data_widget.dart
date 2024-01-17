import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Be the first to post',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
      ),
    );
  }
}
