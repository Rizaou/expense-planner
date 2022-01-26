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