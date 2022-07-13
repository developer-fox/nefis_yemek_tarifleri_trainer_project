


import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:nefis_yemek_tarifleri/classes/post.dart';

import 'package:nefis_yemek_tarifleri/classes/recipe.dart';
import 'package:nefis_yemek_tarifleri/classes/usersDao.dart';

import '../default.dart';
import 'responses.dart';

abstract class RecipesDao{

  RecipesDao();

}


class RecipesDaoRepository{

  // required rapidapi headers
  static Map<String, String> header ={
    'X-RapidAPI-Key': Default.rapidapiKey,
    'X-RapidAPI-Host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
  };

  // api's main router link
  static String mainRouter = "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com";

  //? it returns a list of recipes (helper method)
  List<Recipe> parseRecipesResponse(String response) {

    return RecipesListResponse.fromJson(json.decode(response)).recipes;
  }

  // it returns a random recipes list with item count
  Future<List<Recipe>> getRandomRecipesWithCount(int count) async{

    //! will open when app releasing
    /* 
    var params = {"number": count.toString()};

    var url = Uri.https(mainRouter,"/recipes/random", params);

    var response = await http.get(url, headers: header);
    return parseRecipesResponse(response.body);
    */

    //! will close when app releasing
    List<int> randoms = [];

    for(int i = 0; i < count; i++){
      var num =Default.getRandomNumber(0, 100);
      randoms.add(num);
    }

    var response = await rootBundle.loadString("assets/random_recipes.json");

    var decodedResponse = json.decode(response);
    var recipesList = RecipesListResponse.fromJson(decodedResponse).recipes;

    List<Recipe> result =[];

    for(var i in randoms){
      result.add(recipesList.elementAt(i));
    }

    return result;




  }


  // it returns a recipe with id 
  Future<Recipe> getRecipeWithId(int id) async{

    //! will open when app releasing
    /*
    var url = Uri.https(mainRouter, "/recipes/${id.toString()}/information");

    var response = await http.get(url, headers: header);
    return Recipe.fromJson(json.decode(response.body));
    */

    //! will close when app releasing
    var response = await rootBundle.loadString('../assets/random_recipes.json');
    var decodedResponse = json.decode(response);

    List<Map<String,dynamic>> recipes = decodedResponse["recipes"].cast<Map<String,dynamic>>();

    for(var i in recipes){

      Recipe r = Recipe.fromJson(i);
      if(r.recipeId == id){
        return r;
      }
      else{
        continue;
      }

    }
    return Recipe.fromJson({"":""});

  }

  // it returns 10 similar recipes list with id
  Future<List<Post>> getSimilarPosts(int id) async{

    //! will open when app releasing
    /*
    var  url = Uri.https(mainRouter, "/recipes/${id}/similar");

    var response = await http.get(url, headers: header);

    var body = json.decode(response.body) as List;

    var similarRecipesInfo = body.map((e) {
      return SimilarRecipe.fromJson(e);
    }).toList();

    List<Post> result = [];

    List<User> users = await UsersDaoRepository().getUsersWithCount(similarRecipesInfo.length);

    for(int i = 0; i < users.length; i++){
      Recipe rec = await getRecipeWithId(similarRecipesInfo[i].id);
      result.add(Post(user: users[i], recipe: rec));
    }

    return result;
    */

    //! will close when app release
    var recipes = await getRandomRecipesWithCount(10);

    List<Post> result = [];

    var users = await UsersDaoRepository().getUsersWithCount(recipes.length);

    for(int i = 0; i < recipes.length; i++){
      result.add(Post(user: users[i], recipe: recipes[i]));
    }

    return result;

  }


  // it returns searching autocomplete cook names
  Future<List<SearchingFieldAutocompleteItem>> getSearchingAutocompleteCooks(int count, String searchingWord) async{

    var params = {"query": searchingWord, "number": count.toString()};

    var url = Uri.https(mainRouter, "/recipes/autocomplete", params);

    var response = await http.get(url, headers: header);

    List<Map<String,dynamic>> decodedResponse = json.decode(response.body).cast<Map<String,dynamic>>();

    return decodedResponse.map((e) =>  SearchingFieldAutocompleteItem(name: e["title"], id: e["id"])).toList();


  } 


}


//? helper class for searching autocomplete access
class SearchingFieldAutocompleteItem{

  String name;
  int id;
  SearchingFieldAutocompleteItem({
    required this.name,
    required this.id,
  });

}


//? helper class for similar recipes
class SimilarRecipe extends RecipeParent {

  int id;
  String name;
  int readyMinutes;
  SimilarRecipe({
    required this.id,
    required this.name,
    required this.readyMinutes,
  });


  factory SimilarRecipe.fromJson(Map<String, dynamic> jsonData){

    return SimilarRecipe(
      id: jsonData["id"], 
      name: jsonData["title"],
      readyMinutes: jsonData["readyInMinutes"], 
    );

  }




}



