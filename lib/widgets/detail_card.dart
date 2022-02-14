import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/models/expense_model.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:provider/provider.dart';

enum Screens {
  monthly,
  annual,
}

class DetailCard extends StatefulWidget {
  DetailCard({Key? key}) : super(key: key);
  Screens currentScene = Screens.monthly;
  String title = "Monthly";
  List<ExpenseModel> list = [];
  double textFactor = 1.5;

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  void _changeMenu(Screens value) {
    if (value != widget.currentScene) {
      print("Burada");
      setState(() {
        switch (value) {
          case Screens.monthly:
            widget.currentScene = Screens.monthly;
            widget.title = "Monthly";
            break;

          case Screens.annual:
            widget.currentScene = Screens.annual;
            widget.title = "Annualy";
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    Widget _appBar = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: global_horizontal_padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text("${widget.title} Statistic",
                  textAlign: TextAlign.center),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.expand_more_outlined,
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: PopupMenuButton(
                onSelected: _changeMenu,
                itemBuilder: (_) => [
                  const PopupMenuItem(
                      child: Text('Monthly'), value: Screens.monthly),
                  const PopupMenuItem(
                      child: Text('Annual'), value: Screens.annual),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    Widget showDetail = Row(
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: global_horizontal_padding,
              ),
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all()),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("YOUR MOST EXPENSES",
                            textAlign: TextAlign.center),
                      ),
                      FutureBuilder(
                        future: expenseProvider.getDescOrder
                            .then((value) => widget.list = value),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error");
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Card();
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ...widget.list.map((e) {
                                  var wg = Container(
                                      margin: EdgeInsets.all(
                                          global_horizontal_padding / 2),
                                      child: Text(
                                        e.title,
                                        textScaleFactor: widget.textFactor,
                                      ));
                                  widget.textFactor *= .2;
                                  if (widget.textFactor < .8) {
                                    widget.textFactor = .8;
                                  }
                                  return wg;
                                }).toList()
                              ],
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        Container(
          child: Text("Are2"),
        )
      ],
    );

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: global_horizontal_padding),
      child: Card(
        child: Column(
          children: [
            _appBar,
            showDetail,
          ],
        ),
      ),
    );
  }
}
