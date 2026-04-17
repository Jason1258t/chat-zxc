import 'package:chat_zxc/feature/search/data/search_entity.dart';

class SearchRepository {
  Future<List<SearchEntity>> search(String query) async {
    throw UnimplementedError();
  }

  final Map<String, List<SearchEntity>> _cache = {};
}
