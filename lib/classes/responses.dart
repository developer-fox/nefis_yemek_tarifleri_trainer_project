

import 'package:nefis_yemek_tarifleri/classes/recipe.dart';


class RecipesListResponse {

  List<Recipe> recipes;
  RecipesListResponse({
    required this.recipes,
  });

  factory RecipesListResponse.fromJson(Map<String, dynamic> jsonData){

    var recipes = jsonData["recipes"] as List;

    var recipesInfo = recipes.map((e) {
      return Recipe.fromJson(e);
    }).toList();

    return RecipesListResponse(recipes: recipesInfo);

  }


}



