/// Returns a human-readable relative time string like "just now", "5 minutes ago",
/// "yesterday", "a week ago", "2 months ago", "a year ago", etc.
///
/// [dateTime] - the past (or future) DateTime
/// [now] - optional reference point, defaults to DateTime.now()
String timeAgo(DateTime dateTime, {DateTime? now}) {
  final nowTime = now ?? DateTime.now();
  final diff = nowTime.difference(dateTime);

  // Future case (optional, you may handle differently)
  if (diff.isNegative) {
    return 'in the future';
  }

  final seconds = diff.inSeconds;
  final minutes = diff.inMinutes;
  final hours = diff.inHours;
  final days = diff.inDays;

  if (seconds < 60) {
    return 'just now';
  }
  if (minutes < 60) {
    return minutes == 1 ? 'a minute ago' : '$minutes minutes ago';
  }
  if (hours < 24) {
    return hours == 1 ? 'an hour ago' : '$hours hours ago';
  }
  if (days == 1) {
    return 'yesterday';
  }
  if (days < 7) {
    return '$days days ago';
  }
  if (days < 28) {
    final weeks = days ~/ 7;
    return weeks == 1 ? 'a week ago' : '$weeks weeks ago';
  }
  if (days < 365) {
    final months = (days / 30).floor();
    return months == 1 ? 'a month ago' : '$months months ago';
  }
  final years = (days / 365).floor();
  return years == 1 ? 'a year ago' : '$years years ago';
}