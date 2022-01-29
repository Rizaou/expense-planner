import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/models/income_model.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:gelir_gider/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../providers/program_settings_provider.dart';

class IntroductionScreen extends StatefulWidget {
  IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final pageController = PageController();

  final nameConttroller = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.vertical,
        children: [
          _firstPage(context),
          _secondPage(context),
          _thirdPage(context),
        ],
      ),
    );
  }

  Widget _firstPage(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final settingsProvider = Provider.of<ProgramSettings>(context);
    final firstPageList1 = settingsProvider.firstPageText1;
    final firstPageList2 = settingsProvider.firstPageText2;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: mediaQuery.size.height / 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textScaleFactor: 2,
                text: TextSpan(
                  children: firstPageList1,
                ),
              ),
              Divider(),
              RichText(
                textScaleFactor: 1,
                text: TextSpan(
                  children: firstPageList2,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            alignment: Alignment.center,
            padding:
                EdgeInsets.symmetric(vertical: global_horizontal_padding * 3),
            height: mediaQuery.size.height / 6,
            child: Row(
              children: [
                const Spacer(
                  flex: 5,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: scaffoldBGColor,
                  ),
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _secondPage(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final settingsProvider = Provider.of<ProgramSettings>(context);
    final incomeProvider = Provider.of<IncomeProvider>(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: global_horizontal_padding * 2,
              ),
              child: RichText(
                textScaleFactor: 1,
                text: TextSpan(
                  children: settingsProvider.secontPageText2,
                ),
              ),
              height: mediaQuery.size.height / 4,
            ),
            Text(
              "Please Give A Name for Your Income.",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            // Text(" "),
            // Text(
            //   "For Example : \" My Main Income \"         ",
            //   style: TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
            // Text(" "),
            // Text(
            //   "When you enter an amount\nPlease use this format : 1,000,000.00",
            //   style: TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
            // Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: global_horizontal_padding * 4,
                horizontal: global_horizontal_padding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    controller: nameConttroller,
                    decoration: InputDecoration(
                      hintText: "Name: For Example \" Income1 \"",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusColor: Colors.black,
                      hoverColor: Colors.black,
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height / 10,
                  ),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusColor: Colors.black,
                      hoverColor: Colors.black,
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: scaffoldBGColor,
                ),
                onPressed: () {
                  if (amountController.text.isNotEmpty &&
                      nameConttroller.text.isNotEmpty) {
                    incomeProvider
                        .addIncome(
                      data: IncomeModel(
                        id: 0,
                        income: double.parse(amountController.text.toString()),
                        date: DateTime.now(),
                        description: nameConttroller.text.toString(),
                      ),
                      isFirstTime: true,
                    )
                        .then((value) {
                      print("function completed.");
                      pageController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    });
                  } else {
                    print('all the fields are empt');
                    //TODO: Make this condition.
                  }
                },
              ),
            ),
            //Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _thirdPage(BuildContext context) {
    final settingsProvider = Provider.of<ProgramSettings>(context);
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
        child: Center(
      child: Column(
        children: [
          Spacer(),

          // SizedBox(
          //   height: mediaQuery.size.height / 4,
          // ),
          RichText(
            textScaleFactor: 2,
            text: TextSpan(children: settingsProvider.thirtPageText3),
          ),

          IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
            },
            icon: Icon(
              Icons.done_outline_rounded,
              color: Colors.white,
            ),
          ),
          Spacer(),
        ],
      ),
    ));
  }

  _addIncome() {}
}
