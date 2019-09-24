import 'package:flutter/material.dart';

class AwaitingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
