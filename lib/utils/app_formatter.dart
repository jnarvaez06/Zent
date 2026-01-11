import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppFormatter {

  static String currency(BuildContext context, num value) {
    final locale = Localizations.localeOf(context).toString();
    final format = NumberFormat.simpleCurrency(locale: locale);

    return format.format(value);
  }

  static String dateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }
}