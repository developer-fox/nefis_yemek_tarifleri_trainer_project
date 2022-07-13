import 'package:flutter_bloc/flutter_bloc.dart';
import '../classes/Post.dart';
import '../classes/recipesDao.dart';
import 'SimilarRecipesState.dart';


class SimilarRecipesCubit extends Cubit<SimilarRecipesState>{
  
  SimilarRecipesCubit(): super(SimilarRecipesStarted());


  Future<void> getSimilarRecipesAndTrigger(int recipeId) async{

    try {
      emit(SimilarRecipesLoading());
      var similarRecipes = await RecipesDaoRepository().getSimilarPosts(recipeId);
      emit(SimilarRecipesLoaded(data: similarRecipes));
    }catch (e) {
      emit(SimilarRecipesError(errorMessage: "error occurred while loading similar recipes data"));
    }

  }


}
