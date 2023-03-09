import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geburtstags_app_by_robin/repositories/birthday.repo.dart';
import 'package:geburtstags_app_by_robin/screens/birthday/detail/birthday.detail.screen.dart';
import 'package:geburtstags_app_by_robin/screens/birthday/forms/birthday.form.dart';
import 'package:intl/intl.dart';

import '../../models/birthday.dart';

class BirthdaysScreen extends StatefulWidget {
  const BirthdaysScreen({super.key});

  static final routeName = (BirthdaysScreen).toString();

  @override
  State<BirthdaysScreen> createState() => _BirthdaysScreenState();
}

class _BirthdaysScreenState extends State<BirthdaysScreen> {
  @override
  Widget build(BuildContext context) {
    final birthdays = BirthdayRepo().getBirthdays();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Geburtstage",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: birthdays.length,
          itemBuilder: (context, index) {
            return Dismissible(
                onDismissed: (direction) {
                  setState(() {
                    Birthday birthday = birthdays[index];
                    BirthdayRepo().delete(birthday);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.only(bottom: 75.0),
                        //padding: const EdgeInsets.only(bottom: 30.0),
                        action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            setState(() {
                              BirthdayRepo().insert(birthday);
                            });
                          },
                        ),
                        duration: const Duration(seconds: 4),
                        content:
                            Text("Geburtstag von ${birthday.name} gelöscht")));
                  });
                },
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(birthdays[index].profileImage),
                  title: Text(birthdays[index].name),
                  subtitle: Text(birthdays[index].genderString!),
                  trailing: Text(
                      DateFormat("dd.MM.yyyy").format(birthdays[index].date)),
                  onTap: () {
                    Navigator.pushNamed(context, BirthdayDetailScreen.routeName,
                            arguments: birthdays[index])
                        .then(
                      (value) => setState(() {}),
                    );
                  },
                ));
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add_alt_1),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return const BirthdayForm();
                  },
                ),
              )
              .then((value) => setState(() {
                    //refresh birthday list
                  }));
        },
      ),
    );
  }
}
