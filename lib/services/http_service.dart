import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  static const _BASEURL = 'https://g.tenor.com/v1';

  static Future<List<dynamic>> searchGif(String searchKeyword) async {
    try {
      var url = Uri.parse(_BASEURL + '/search?q=$searchKeyword&key=LIVDSRZULELA&limit=10');
      var result = await http.get(url);
      if (result.statusCode == 200) {
        var resultContent = jsonDecode(result.body);
        List<dynamic> gifs = resultContent['results'];
        return gifs;
      }
      return [];
    } catch (e) {
      print('Hata oluştu: $e');
      return [];
    }
  }
}
