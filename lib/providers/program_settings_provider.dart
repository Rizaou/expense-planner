//TODO: Make program setting provider

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Languages { tr, en }

class ProgramSettings with ChangeNotifier {
  Languages _prog_lang = Languages.en;

  Map<dynamic, dynamic> en_text = {
    'income': "Income",
    "expense": "Expense",
    "graphic": "Graphic",
    "add_expense": "Add Expense",
    "add_income": "Add Income",
    "amount": "Amount",
    "type": "Type",
    "add": "Add",
    "title": "Title",
    "error": "Error",
    "loading": "Loading",
    "home_page": "Home Page",
    "no_transaction": "No Transaction Added",
  };

  Map<dynamic, dynamic> tr_text = {
    'income': "Gelir",
    "expense": "Gider",
    "graphic": "Grafik",
    "add_expense": "Harcama Ekle",
    "add_income": "Gelir Ekle",
    "amount": "Miktar",
    "type": "Tür",
    "add": "Ekle",
    "title": "Başlık",
    "error": "Hata",
    "loading": "Yükleniyor",
    "home_page": "Ana Sayfa",
    "no_transaction": "Harcama Eklemediniz",
  };

  Languages get getLanguage => _prog_lang;

  List<TextSpan> get firstPageText1 => [
        TextSpan(
          text: "WELCOME\n",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: "TO\n",
        ),
        TextSpan(
          text: "THE APP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ];
  List<TextSpan> get firstPageText2 => [
        TextSpan(
          text: "WE WILL HELP YOU\n",
          //style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: "TO\n",
        ),
        TextSpan(
          text: "CONTROL YOUR\n",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: "MONEY\n",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ];

  List<TextSpan> get secontPageText2 => [
        TextSpan(
          text: "LET'S ENTER YOUR INCOME(S)\n",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        // TextSpan(
        //   text: "Please give a name for your\n",
        //   style: TextStyle(),
        // ),
        // TextSpan(
        //   text: "Income\n",
        //   style: TextStyle(),
        // ),
      ];
  List<TextSpan> get thirtPageText3 => [
        TextSpan(
          text: "GOOD TO GO!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ];

  void changeLanguage(Languages ln) {
    switch (ln) {
      case Languages.tr:
        break;

      case Languages.en:
        break;
    }

    notifyListeners();
  }
}
//* 
//* Language,
//*   
//*
//*
//*/