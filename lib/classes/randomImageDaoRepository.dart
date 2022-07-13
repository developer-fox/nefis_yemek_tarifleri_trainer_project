
import 'package:http/http.dart' as http;
import 'package:nefis_yemek_tarifleri/classes/randomTextDaoRepository.dart';
import 'package:nefis_yemek_tarifleri/classes/usersDao.dart';
import 'dart:convert';
import '../default.dart';
import "randomImage.dart";

abstract class randomImageDao{
  randomImageDao();
}


class RandomImageDaoRepository implements randomImageDao{

  static var headers = {
    'X-RapidAPI-Key': Default.rapidapiKey,
    'X-RapidAPI-Host': 'hargrimm-wikihow-v1.p.rapidapi.com'
  };

  static var mainRouter ='hargrimm-wikihow-v1.p.rapidapi.com';

  Future<List<RandomImage>> getRandomImagesWithCount (int count) async{

    var url = Uri.https(mainRouter, "/images", {"count": count.toString()});

    var response = await http.get(url, headers: headers);

    var decodedResponse = json.decode(response.body) as Map<String, dynamic>;

    var users = await UsersDaoRepository().getUsersWithCount(count);

    var comments = await RandomTextDaoRepository().getRandomText(count);

    List<RandomImage> result = [];

    for(int i=0; i< decodedResponse.values.length; i++){
      result.add(RandomImage(
        imageUrl: decodedResponse[(i+1).toString()] ?? Default.errorImagePath,
        sender: users[i],
        comment: comments[i]
      ));
    
    }

    return result;

  }


}


