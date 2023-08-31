import 'package:intl/intl.dart';

class Utils {
  static String formatDate(DateTime time) {
    final format = DateFormat.yMMMMEEEEd();
    return format.format(time);
  }
}