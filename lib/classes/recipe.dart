
import 'dart:math';
import '../default.dart';
import 'ingredient.dart';

abstract class RecipeParent{

  RecipeParent();
}


class Recipe extends RecipeParent{

  int recipeId;
  String recipeName;
  String recipeImageUrl;
  int readyInMinutes;
  int stars;
  List<Ingredient> ingredients;
  List<String> steps;
  int likes;
  int servings;
  double pricePerServing;

  Recipe({
    required this.recipeId,
    required this.recipeName,
    required this.recipeImageUrl,
    required this.readyInMinutes,
    required this.stars,
    required this.ingredients,
    required this.steps,
    required this.likes,
    required this.servings,
    required this.pricePerServing,
  });


  // create Recipe object from decoded json data
  factory Recipe.fromJson(Map<String, dynamic> jsonData){

    List<Map<String, dynamic>> igAtJson = jsonData["extendedIngredients"].cast<Map<String, dynamic>>();

    return Recipe(
      recipeId: jsonData["id"], 
      recipeName: jsonData["title"], 
      recipeImageUrl: jsonData["image"] ?? Default.errorImagePath, 
      readyInMinutes: jsonData["readyInMinutes"], 
      stars: countOfStarts(), 
      ingredients: igAtJson.map((e) {
        return Ingredient.fromJson(e);
      }).toList(), 
      steps: instructionsToSteps(jsonData["instructions"] ?? "")  , 
      likes: jsonData["aggregateLikes"], 
      servings: jsonData["servings"], 
      pricePerServing: jsonData["pricePerServing"],
      );


  }



  // converting html list to string list 
  static List<String> instructionsToSteps(String htmlList){

    if(htmlList.contains("<ol>") || htmlList.contains("<ul>")){

      var instructionsWithOutOlTags = htmlList.substring(4, htmlList.length-5);

      var instructionsSplittedLastLiTags = instructionsWithOutOlTags.split("</li>");

      instructionsSplittedLastLiTags.removeAt(instructionsSplittedLastLiTags.length-1);

      List<String> result = [];

      for(var i in instructionsSplittedLastLiTags){
        result.add(i.substring(4));
      }

      return result;
    }
    else{
      var instructionsSplittedDots = htmlList.split(".");
      return instructionsSplittedDots;
    }

  }


  // random star count generator
  static int countOfStarts(){

   var rand = Random();
   int randomStars = rand.nextInt(5) +1;
    return randomStars;
  }



}

