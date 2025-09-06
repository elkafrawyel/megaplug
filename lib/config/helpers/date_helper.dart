import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
      dateFormat: DateFormat('EE, dd MMMM', StorageClient().getAppLanguage()),
    );
    String newDate = getDateFromDateString(
      dateString,
      dateFormat: DateFormat('EE, dd MMMM', StorageClient().getAppLanguage()),
    );

    return todayDate == newDate;
  }

  bool isYesterday(String dateString) {
    String yesterdayDate = getDateFromDate(
      DateTime.now().subtract(const Duration(days: 1)),
      dateFormat: DateFormat('EE, dd MMMM', StorageClient().getAppLanguage()),
    );
    String newDate = getDateFromDateString(
      dateString,
      dateFormat: DateFormat('EE, dd MMMM', StorageClient().getAppLanguage()),
    );

    return yesterdayDate == newDate;
  }

  /// Formats a date string into a human-readable format.
  /// The date string is expected to be in ISO 8601 format (e.g., "2023-01-02T15:04:05Z").
  /// If the date is today, it returns "today • HH:mm AM/PM".
  /// If the date is yesterday, it returns "yesterday • HH:mm AM/PM".
  /// Otherwise, it returns "d MMM y • HH:mm AM/PM".
  /// The time is formatted according to the app's language setting.
  String formatDateTime(String? date) {
    if (date == null) return '';
    // Parse the date string to a DateTime object
    // Assuming the date string is in ISO 8601 format (e.g., "2023-01-02T15:04:05Z")
    // If the date string is in a different format, you may need to adjust the parsing accordingly.
    // For example, if the date string is in "yyyy-MM-dd HH:mm:ss" format, use DateTime.parse(date) directly.
    // If the date string is in a different format, you may need to adjust the parsing accordingly.
    DateTime dateTime = DateTime.parse(date).toLocal();
    // Get the current date and time
    // Compare the date with today and yesterday
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final inputDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    // Format the time part
    // Use the app's language setting for formatting
    // For example, if the app's language is English, it will format as "4:32 PM"
    // If the app's language is Arabic, it will format as "٤:٣٢ م"
    final timeFormat = DateFormat.jm(StorageClient().getAppLanguage());

    if (inputDate == today) {
      return '${'today'.tr} • ${timeFormat.format(dateTime)}';
    } else if (inputDate == yesterday) {
      return '${'yesterday'.tr} • ${timeFormat.format(dateTime)}';
    } else {
      final fullDateFormat = DateFormat('d MMM y', StorageClient().getAppLanguage()); // e.g., 2 Jan 2023
      return '${fullDateFormat.format(dateTime)} • ${timeFormat.format(dateTime)}';
    }
  }
}
