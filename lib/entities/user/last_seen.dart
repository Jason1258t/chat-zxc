part of 'profile.dart';

enum LastSeenDataType { shown, hidden }

class LastSeenData {
  final LastSeenDataType type;
  final String _rawData;

  LastSeenData({required this.type, required String data}) : _rawData = data;

  String get value {
    if (type == .shown) {
      return timeAgo(DateTime.parse(_rawData));
    }

    return _rawData;
  }
}
