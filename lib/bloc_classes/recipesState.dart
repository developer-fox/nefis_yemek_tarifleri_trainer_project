

import '../classes/recipe.dart';

abstract class RecipesState{
  RecipesState();
}



class RecipesStarted extends RecipesState{
  RecipesStarted();
}

class RecipesLoading extends RecipesState{
  RecipesLoading();
}

class RecipesLoaded extends RecipesState {
  List<Recipe> recipe;
  RecipesLoaded({
    required this.recipe,
  });
}

class RecipesError extends RecipesState {
  String errorMessage;
  RecipesError({
    required this.errorMessage,
  });
}


