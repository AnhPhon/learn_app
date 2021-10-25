import 'package:intl/intl.dart';

mixin DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String formatDateTimeHHmm(DateTime dateTime) {
    return DateFormat('HH:mm dd-MM-yyyy').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String estimatedDateOnly(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String estimatedDateMonthYear(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String formatYYYYMMDD(String dateTime) {
    //dd mm yyyy
    final date = DateFormat('dd-MM-yyyy').parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateTime);
  }

  static DateTime convertStringToDateOnly(String dateTime) {
    return DateFormat('yyyy-MM-dd').parse(dateTime);
  }

  static DateTime convertStringddMMyyyyToDate(String dateTime) {
    return DateFormat('dd-MM-yyyy').parse(dateTime);
  }

  static DateTime convertStringToDatetimeddMMyyyy(String dateTime) {
    return DateFormat('HH:mm dd-MM-yyyy').parse(dateTime);
  }

  static DateTime convertStringToddMMyyyyDatetime(String dateTime) {
    return DateFormat('dd-MM-yyyy').parse(dateTime);
  }

  static DateTime convertStringToDate(String dateTime) {
    return DateFormat('dd-MM-yyyy').parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime).toLocal();
  }

  static DateTime stringToLocalDate(String dateTime) {
    return DateTime.parse(dateTime).toLocal();
  }

  static DateTime isoStringDateTimeToDateTime(String dateTime) {
    return DateTime.parse(dateTime).toLocal();
  }

  static String isoStringToddMMYYYY(String dateTime) {
    return DateFormat('dd/MM/yyyy')
        .format(isoStringDateTimeToDateTime(dateTime));
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('HH:mm').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd:MM:yy').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalFullDateOnly(String dateTime) {
    return DateFormat('dd-MM-yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateHMS(String dateTime) {
    return DateFormat('HH:mm dd/MM/yyyy')
        .format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToVNDateOnly(String dateTime) {
    return DateFormat('dd/MM/yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateFull(String dateTime) {
    return DateFormat('dd/MM/yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime.toUtc());
  }

  static String localDateToIsoStringHaveHour(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime.toUtc());
  }

  static String localDateToIsoStringyyyyMMdd(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime.toUtc());
  }

  static int differenceDate(
      {required String startDate, required String endDate}) {
    return int.parse(convertStringToDate(endDate)
        .difference(convertStringToDate(startDate))
        .inDays
        .toString());
  }

  static String formatDateTime(String dateTime) {
    return DateConverter.isoStringToLocalFullDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  static String formatDateTimeFull({required String dateTime}) {
    return DateConverter.isoStringToLocalDateHMS(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  static String readMongoToString(String dateTimeStr) {
    final String first10letter = dateTimeStr.substring(0, 10);
    return DateFormat('dd/MM/yyyy').format(
      DateFormat('yyyy-MM-dd').parse(first10letter),
    );
  }

  static String readMongoToStringyyyyMMdd(String dateTimeStr) {
    final String first10letter = dateTimeStr.substring(0, 10);
    return DateFormat('yyyy-MM-dd').format(
      DateFormat('yyyy-MM-dd').parse(first10letter),
    );
  }

  static String isoStringToFullVNDateOnly(String dateTime) {
    final String dd = DateFormat('dd').format(isoStringToLocalDate(dateTime));
    final String mm = DateFormat('MM').format(isoStringToLocalDate(dateTime));
    final String yy = DateFormat('yyy').format(isoStringToLocalDate(dateTime));
    return "Ngày $dd tháng $mm năm $yy";
  }

  static int toTimeStamp(DateTime dateTime) {
    return int.parse(dateTime.millisecondsSinceEpoch.toStringAsFixed(0)) +
        25200;
  }
}
