import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/space_content_item.dart';

class SpaceflightNewsService {
  const SpaceflightNewsService();

  static const String _baseUrl = 'https://api.spaceflightnewsapi.net/v4';

  Future<List<SpaceContentItem>> fetchItems(String menu) async {
    final Uri uri = Uri.parse('$_baseUrl/$menu/?limit=10');
    final http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat data $menu');
    }

    final Map<String, dynamic> decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> results = decoded['results'] as List<dynamic>? ?? const [];

    return results
        .map((dynamic item) => SpaceContentItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<SpaceContentItem> fetchDetail(String menu, int id) async {
    final Uri uri = Uri.parse('$_baseUrl/$menu/$id/');
    final http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat detail $menu');
    }

    final Map<String, dynamic> decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return SpaceContentItem.fromJson(decoded);
  }
}