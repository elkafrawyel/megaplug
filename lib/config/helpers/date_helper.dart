import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:intl/intl.dart';

class DateHelper {
  String getTimeFromDateString(String? dateString, {DateFormat? dateFormat}) {
    if (dateString == null) {
      return '';
    } else {
      return DateFormat(
        dateFormat?.pattern ?? DateFormat.HOUR_MINUTE,
        StorageClient().getAppLanguage(),
      ).format(
        DateTime.parse(dateString),
      );
    }
  }

  String getTimeFromDate(DateTime? date, {DateFormat? dateFormat}) {
    if (date == null) {
      return '';
    } else {
      return DateFormat(
        dateFormat?.pattern ?? DateFormat.HOUR_MINUTE,
        StorageClient().getAppLanguage(),
      ).format(date);
    }
  }

  String getDateFromDateString(String? dateString, {DateFormat? dateFormat}) {
    if (dateString == null) {
      return '';
    } else {
      return DateFormat(
        dateFormat?.pattern ?? DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
        StorageClient().getAppLanguage(),
      ).format(
        DateTime.parse(dateString),
      );
    }
  }

  String getDateFromDate(DateTime? date, {DateFormat? dateFormat}) {
    if (date == null) {
      return '';
    } else {
      return DateFormat(
        dateFormat?.pattern ?? DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
        StorageClient().getAppLanguage(),
      ).format(date);
    }
  }

  bool isToday(String dateString) {
    String todayDate = getDateFromDate(
      DateTime.now(),
      dateFormat: DateFormat('EE, dd MMMM'),
    );
    String newDate = getDateFromDateString(
      dateString,
      dateFormat: DateFormat('EE, dd MMMM'),
    );

    return todayDate == newDate;
  }

  bool isYesterday(String dateString) {
    String yesterdayDate = getDateFromDate(
      DateTime.now().subtract(const Duration(days: 1)),
      dateFormat: DateFormat('EE, dd MMMM'),
    );
    String newDate = getDateFromDateString(
      dateString,
      dateFormat: DateFormat('EE, dd MMMM'),
    );

    return yesterdayDate == newDate;
  }

  String formatDateTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final inputDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final timeFormat = DateFormat.jm(); // e.g., 4:32 PM

    if (inputDate == today) {
      return 'Today • ${timeFormat.format(dateTime)}';
    } else if (inputDate == yesterday) {
      return 'Yesterday • ${timeFormat.format(dateTime)}';
    } else {
      final fullDateFormat = DateFormat('d MMM y'); // e.g., 2 Jan 2023
      return '${fullDateFormat.format(dateTime)} • ${timeFormat.format(dateTime)}';
    }
  }
}
