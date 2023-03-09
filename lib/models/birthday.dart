import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Birthday {
  Birthday({required this.name, required this.date, required this.gender}) {
    if (gender == Genders.male) {
      genderString = "männlich";
      profileImage = Icons.male_outlined;
    } else {
      genderString = "weiblich";
      profileImage = Icons.female_outlined;
    }
    dateString = DateFormat("dd.MM.yyyy").format(date);
  }

  String name;
  DateTime date;
  String? dateString;
  Genders gender;
  String? genderString;
  IconData? profileImage;
  String? notes;
}

enum Genders { male, female }
