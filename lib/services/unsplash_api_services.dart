import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UnsplashApiServices {
  static const baseUrl = 'https://api.unsplash.com';

  static Future<String?> getRandomCityImage({required String city}) async {
    var url =
        '$baseUrl/search/photos?query=$city&orientation=landscape&per_page=1&client_id=${dotenv.env['UNSPLASH_API_KEY']}';
    print("Request Api: $url");
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) return null;
    return jsonDecode(res.body)['results'][0]['urls']['small'];
  }
}
