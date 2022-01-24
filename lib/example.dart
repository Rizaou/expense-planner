import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider_expenses.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final control = ItemScrollController();

  Future<void> focus() async {
    control.scrollTo(index: 9, duration: const Duration(seconds: 1));
  }

  String value = 'Text';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('yeni')),
      body: ScrollablePositionedList.builder(
        itemScrollController: control,
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 100,
          child: Text((index + 1).toString()),
          padding: const EdgeInsets.all(12),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          focus();
        },
        child: Icon(Icons.ac_unit_rounded),
      ),
    );
  }
}

// PageView(
//         scrollDirection: Axis.vertical,
//         children: [
//           Center(
//             child: Text('Page1'),
//           ),
//           Center(
//             child: Text('Page2'),
//           )
//         ],
//       ),