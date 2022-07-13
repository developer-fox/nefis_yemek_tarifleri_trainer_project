import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:nefis_yemek_tarifleri/default.dart';
import 'user.dart';


abstract class UsersDao{
  UsersDao();
}


class UsersDaoRepository implements UsersDao{

  
  // it gets a random user
  Future<User> getRandomUser() async{

    var url = Uri.parse("https://random-user.p.rapidapi.com/getuser");
    var response = await http.get(url, headers: {
    'X-RapidAPI-Key': Default.rapidapiKey,
    'X-RapidAPI-Host': 'random-user.p.rapidapi.com'
      });

    var decodedBody = json.decode(response.body);

    return User.fromJson(decodedBody);

  }

  Future<List<User>> getUsersWithCount(int count) async{

    List<User> result = [];

    for(int i =0; i< count; i++){
      var user = await getRandomUser();
      result.add(user);
    }
    return result;
  }




}




