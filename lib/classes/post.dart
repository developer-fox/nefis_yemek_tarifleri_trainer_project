
import 'recipe.dart';
import 'recipesDao.dart';
import 'user.dart';
import 'usersDao.dart';

class Post {
  User user;
  Recipe recipe;

  Post({
    required this.user,
    required this.recipe,
  });





}

   Future<Post> getPostWithRecipeId(int id) async{

    var user = await UsersDaoRepository().getRandomUser();
    var recipe = await RecipesDaoRepository().getRecipeWithId(id);
    return Post(user: user, recipe: recipe);
  }

  // it returns random user(s). count parameters default value 1.
   Future<List<Post>> getRandomPost({int count =1}) async{
    var users = await UsersDaoRepository().getUsersWithCount(count);
    var recipes = await RecipesDaoRepository().getRandomRecipesWithCount(count);

    List<Post> result = [];
    for(int i =0; i< count; i++){
      result.add(Post(user: users[i], recipe: recipes[i]));
    }
    return result;
  }
