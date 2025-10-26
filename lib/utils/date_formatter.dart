import 'package:intl/intl.dart';

class DateFormatter {
  // Format: "2 hours ago", "3 days ago", etc.
  static String timeAgo(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return '';

    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';

    return DateFormat('MMM dd, yyyy').format(date);
  }

  // Format: "MMM dd, yyyy"
  static String standardDate(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return '';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  // Format: "Today at 3:20 PM"
  static String todayOrTime(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return '';

    final now = DateTime.now();
    final isToday = date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;

    if (isToday) {
      return 'Today at ${DateFormat('h:mm a').format(date)}';
    } else {
      return DateFormat('MMM dd, h:mm a').format(date);
    }
  }
}
