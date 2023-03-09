import 'package:flutter/material.dart';
import 'package:geburtstags_app_by_robin/models/birthday.dart';
import 'package:geburtstags_app_by_robin/repositories/birthday.repo.dart';

class BirthdayForm extends StatefulWidget {
  const BirthdayForm({super.key, this.birthday, this.isEdit = false});

  static final routeName = (BirthdayForm).toString();

  final Birthday? birthday;
  final bool isEdit;

  static const List<String> dropDownList = <String>["", "männlich", "weiblich"];
  @override
  State<BirthdayForm> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends State<BirthdayForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController foreNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController dayController = TextEditingController();

  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    widget.birthday?.genderString ??= BirthdayForm.dropDownList.first;
    dropDownValue ??= widget.birthday?.genderString;
    if (widget.isEdit) {
      foreNameController =
          TextEditingController(text: widget.birthday!.foreName);
      lastNameController =
          TextEditingController(text: widget.birthday!.lastName);
      yearController =
          TextEditingController(text: widget.birthday!.date.year.toString());
      monthController =
          TextEditingController(text: widget.birthday!.date.month.toString());
      dayController =
          TextEditingController(text: widget.birthday!.date.day.toString());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neuer Geburtstag"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate() && dropDownValue != "") {
                Genders gender = Genders.female;
                if (dropDownValue == "männlich") {
                  gender = Genders.male;
                }
                Birthday birthday = Birthday(
                    foreName: foreNameController.text,
                    lastName: lastNameController.text,
                    date: DateTime(
                        int.parse(yearController.text),
                        int.parse(monthController.text),
                        int.parse(dayController.text)),
                    gender: gender);
                if (widget.isEdit) {
                  BirthdayRepo().update(
                      oldBirthday: widget.birthday!, newBirthday: birthday);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Geburtstag geändert")));
                } else {
                  BirthdayRepo().insert(birthday);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Geburtstag hinzugefügt")));
                }
                Navigator.pop(context, birthday);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text("Bitte alle notwendigen Felder ausfüllen")));
              }
            },
            child: const Text(
              "Speichern",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: foreNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: "Vorname"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bitte Vornamen eingeben";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      controller: lastNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: "Nachname"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bitte Nachnamen eingeben";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: yearController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: "Jahr"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bitte Jahr eingeben";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      controller: monthController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: "Monat"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bitte Monat eingeben";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      controller: dayController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: "Tag"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bitte Tag eingeben";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              DropdownButton<String>(
                value: dropDownValue,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                  });
                },
                items: BirthdayForm.dropDownList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
