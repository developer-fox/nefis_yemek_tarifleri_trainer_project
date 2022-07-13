


import 'package:nefis_yemek_tarifleri/classes/comment.dart';

import 'package:nefis_yemek_tarifleri/classes/usersDao.dart';

import '../default.dart';
import 'user.dart';

class CommentDaoRepository{


  // returns a comments list with count
  static Future<List<Comment>> getCommentsWithCount(int count) async{

    List<User> users = await UsersDaoRepository().getUsersWithCount(count);
    
    List<Comment> result = [];

    for(var i = 0; i <count; i++){
      Comment c = await Comment.createCommentAsync(users[i]);
      result.add(c);
    }

    return result;
  }


}

