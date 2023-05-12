import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ScryfallService {
  Future getResponse(String urlEncodedQuery) async {
    dynamic responseJson;
    try {
      final response = await http.get(
          Uri.parse('https://api.scryfall.com/cards/search?order=cmc&q=$urlEncodedQuery'));
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
    }
  }
}
