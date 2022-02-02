import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        height: global_card_height_px,
        child: Text('Detail card'),
      ),
    );
  }
}
