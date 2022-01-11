import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatefulWidget {
  CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  _CustomFloatingActionButtonState createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: SizedBox(
            width: 50,
            height: 50,
          ),
        ),
        Card(
          child: SizedBox(
            width: 50,
            height: 50,
          ),
        )
      ],
    );
  }
}
