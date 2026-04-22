import 'package:intl/intl.dart';

enum BirthdayPrivacyLvl { fullDate, day }

String birthDayDate(
    DateTime date, [
      BirthdayPrivacyLvl privacyLvl = BirthdayPrivacyLvl.fullDate,
    ]) {
  final now = DateTime.now();
  final formatter = DateFormat(
    privacyLvl == BirthdayPrivacyLvl.fullDate ? 'MMM dd, yyyy' : 'MMM dd',
  );
  final formattedDate = formatter.format(date);

  if (privacyLvl == BirthdayPrivacyLvl.fullDate) {
    int age = now.year - date.year;
    // Check if birthday has occurred this year yet
    if (now.month < date.month ||
        (now.month == date.month && now.day < date.day)) {
      age--;
    }
    return '$formattedDate ($age years old)';
  } else {
    return formattedDate;
  }
}