import '../models/birthday.dart';

class BirthdayRepo {
  static final BirthdayRepo _birthdayRepo = BirthdayRepo._internal();

  factory BirthdayRepo() {
    return _birthdayRepo;
  }

  BirthdayRepo._internal() {
    _birthdays.add(Birthday(
        name: "Robin Laloi",
        date: DateTime(1995, 7, 14),
        gender: Genders.male));
    _birthdays.add(Birthday(
        name: "Peter Lustig",
        date: DateTime(1995, 7, 15),
        gender: Genders.male));
    _birthdays.add(Birthday(
        name: "Belli Laloi",
        date: DateTime(1970, 5, 31),
        gender: Genders.female));
    _birthdays.add(Birthday(
        name: "Willi Laloi",
        date: DateTime(1964, 2, 17),
        gender: Genders.male));
    _birthdays.add(Birthday(
        name: "Chiara Laloi",
        date: DateTime(1997, 8, 14),
        gender: Genders.female));
    _birthdays.add(Birthday(
        name: "Emmi Laloi",
        date: DateTime(2012, 10, 26),
        gender: Genders.female));
    _birthdays.add(Birthday(
        name: "Blabla Bla", date: DateTime(1982, 3, 8), gender: Genders.male));
  }

  final List<Birthday> _birthdays = [];

  List<Birthday> getBirthdays() {
    return _birthdays;
  }

  Birthday insert(Birthday birthday) {
    _birthdays.add(birthday);
    return birthday;
  }

  Birthday update({required Birthday oldBirthday, required newBirthday}) {
    _birthdays.remove(oldBirthday);
    _birthdays.add(newBirthday);
    return newBirthday;
  }

  void delete(Birthday birthday) {
    _birthdays.remove(birthday);
  }
}
