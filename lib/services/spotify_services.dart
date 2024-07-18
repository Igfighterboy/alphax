import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class SpotifyService {
  final String clientId = '88cabdbf1cd44f938e4e2f25f409a144';
  final String clientSecret = '03bff4da2bee418da213d7956738e54f';
  String? _accessToken;

  final List<String> markets = [
    'US',
    'IN',
    'FR',
    'DE',
    'JP',
    'BR',
    'GB',
    'CA',
    'AU',
    'MX'
  ];

  final List<String> languages = [
    'ml'
  ];

  Future<void> _getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
            'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret')),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data['access_token'];
    } else {
      throw Exception('Failed to retrieve access token');
    }
  }

  String _getRandomMarket() {
    final random = Random();
    return markets[random.nextInt(markets.length)];
  }

  String _getRandomLanguage() {
    final random = Random();
    return languages[random.nextInt(languages.length)];
  }

  Future<List<Map<String, dynamic>>> fetchnewRelease() async {
    if (_accessToken == null) {
      await _getAccessToken();
    }

    final randomMarket = _getRandomMarket();

    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/browse/new-releases?market=$randomMarket'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['albums']['items']);
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPopularAlbums() async {
    if (_accessToken == null) {
      await _getAccessToken();
    }

    final randomLanguage = _getRandomLanguage();

    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/browse/categories?locale=$randomLanguage'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Map<String, dynamic>> categories =
          List<Map<String, dynamic>>.from(data['categories']['items']);

      List<Map<String, dynamic>> popularAlbums = [];

      for (var category in categories) {
        final categoryId = category['id'];
        final categoryResponse = await http.get(
          Uri.parse(
              'https://api.spotify.com/v1/browse/categories/$categoryId/playlists'),
          headers: {
            'Authorization': 'Bearer $_accessToken',
          },
        );

        if (categoryResponse.statusCode == 200) {
          final categoryData = jsonDecode(categoryResponse.body);
          popularAlbums.addAll(List<Map<String, dynamic>>.from(
              categoryData['playlists']['items']));
        }
      }
      return popularAlbums;
    } else {
      throw Exception('Failed to load popular albums');
    }
  }
}
