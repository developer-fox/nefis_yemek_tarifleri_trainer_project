
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nefis_yemek_tarifleri/classes/randomText.dart';
import 'package:nefis_yemek_tarifleri/default.dart';

abstract class RandomTextDao{

  RandomTextDao();

}


class RandomTextDaoRepository implements RandomTextDao{

  static var mainRoute = 'hargrimm-wikihow-v1.p.rapidapi.com';

  static var headers = {
    'X-RapidAPI-Key': Default.rapidapiKey,
    'X-RapidAPI-Host': 'hargrimm-wikihow-v1.p.rapidapi.com'};


  // returns randomText list
  Future<List<RandomText>> getRandomText(int count) async{

    var url = Uri.https(mainRoute,"/steps", {"count": count.toString()});
    var response = await http.get(url, headers: headers);

    var decodedResponse = json.decode(response.body);

    Map elements = decodedResponse as Map<String, dynamic>;
    List<RandomText> result = [];

    for(int i = 0; i< elements.length; i++){
      result.add(RandomText(content: elements[(i+1).toString()]));
    }

    return result;

  }

}

