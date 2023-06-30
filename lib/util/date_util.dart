class DateUtility {
  static List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  static List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static bool isSameDay(DateTime? date1, DateTime? date2) =>
      date1 == null || date2 == null
          ? false
          : date1.year == date2.year &&
              date1.month == date2.month &&
              date1.day == date2.day;

  static String getWeekdayName(int weekday) {
    // 당일 기준으로 5일치를 가져옴으로 요일이 같다면 오늘이다.
    if (DateTime.now().weekday == weekday) {
      return 'Today';
    }
    return weekday > 0 && weekday < 8 ? weekdays[weekday - 1] : '';
  }

  static getMonthName(int month) =>
      month > 0 && month < 13 ? months[month - 1] : '';
}
