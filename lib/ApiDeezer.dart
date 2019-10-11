import 'package:http/http.dart' as http;

abstract class ApiDeezer {
  static final urlHeader = 'https://api.deezer.com/';

  static Future getIdByArtiste(String artiste) async {
    var url = '$urlHeader search?q= $artiste';
    return await http.get(url);
  }

  static Future getArtisteById(int id) async {
    var url = '${urlHeader}artist/$id';
    return await http.get(url);
  }

  static Future getTopMusicByArtisteId(int id) async {
    var url = '$urlHeader artist/ $id /top?limit=100';
    return await http.get(url);
  }

  static Future getMusicById(int id) async {
    var URL = 'https://api.deezer.com/track/ $id';
    return await http.get(URL);
  }
}
