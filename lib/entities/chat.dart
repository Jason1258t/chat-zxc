abstract interface class Chat {
  String get name;

  String? get imageUrl;
}

class DirectChat implements Chat {
  @override
  final String name;

  @override
  final String? imageUrl;

  DirectChat({required this.name, required this.imageUrl});
}
