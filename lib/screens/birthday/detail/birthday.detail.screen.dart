import 'package:flutter/material.dart';
import 'package:geburtstags_app_by_robin/models/birthday.dart';
import 'package:geburtstags_app_by_robin/repositories/birthday.repo.dart';
import 'package:geburtstags_app_by_robin/screens/birthday/forms/birthday.form.dart';

class BirthdayDetailScreen extends StatefulWidget {
  const BirthdayDetailScreen({super.key});

  static final routeName = (BirthdayDetailScreen).toString();

  @override
  State<StatefulWidget> createState() => _BirthdayDetailScreenState();
}

class _BirthdayDetailScreenState extends State<BirthdayDetailScreen> {
  Birthday? birthday;

  @override
  Widget build(BuildContext context) {
    birthday ??= ModalRoute.of(context)!.settings.arguments as Birthday;

    void _showAlertDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("${birthday!.name} wirklich löschen?"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Abbrechen")),
                TextButton(
                  child: const Text("Löschen"),
                  onPressed: () {
                    BirthdayRepo().delete(birthday!);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Geburtstag"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Bearbeiten"),
                ),
                const PopupMenuItem(value: 1, child: Text("Löschen"))
              ];
            },
            onSelected: (value) async {
              if (value == 0) {
                final updatedBirthday =
                    await Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return BirthdayForm(birthday: birthday, isEdit: true);
                  },
                ));
                setState(() {
                  birthday = updatedBirthday;
                });
              } else if (value == 1) {
                _showAlertDialog();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${birthday!.name}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text("Geschlecht: ${birthday!.genderString}"),
            const SizedBox(height: 15),
            Text("Alter: ${birthday!.dateString}"),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Zurück",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
