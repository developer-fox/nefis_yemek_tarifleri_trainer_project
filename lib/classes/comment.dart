


import 'package:nefis_yemek_tarifleri/classes/randomText.dart';
import 'package:nefis_yemek_tarifleri/classes/user.dart';

import '../default.dart';
import 'randomTextDaoRepository.dart';

class Comment {

  late User user;
  RandomText content;
  late int favs;
  Comment({
    required this.user,
    required this.content,
    }){
      favs = Default.getRandomNumber(0, 1000);
    }


  static Future<Comment> createCommentAsync(User user) async{

    var getContentAsList = await RandomTextDaoRepository().getRandomText(1);
    var content = getContentAsList[0];

    return Comment(user: user, content:content);


  }


}

