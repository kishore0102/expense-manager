import 'package:intl/intl.dart';

class DateUtils {

  static final formatter_full = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final formatter_yymm = DateFormat('yyyy-MM');
  static final formatter_date = DateFormat('yyyy-MM-dd');

  static String currentDateToString() {
    var dt = DateTime.now();
    String formatted = formatter_full.format(dt);
    return formatted;
  }

  static String timeToDate(time) {
    return formatter_date.format(time);
  }

  static String currentDateToStringInYearMonth() {
    var dt = DateTime.now();
    String formatted = formatter_yymm.format(dt);
    return formatted;   
  }

  static DateTime stringToDate(String date) {
    return formatter_full.parse(date);
  }

}