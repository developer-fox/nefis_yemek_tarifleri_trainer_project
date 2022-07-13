import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nefis_yemek_tarifleri/classes/recipesDao.dart';

import '../classes/recipe.dart';
import 'recipesState.dart';



class UserDetailsSecondTabCubit extends Cubit<RecipesState>{
  UserDetailsSecondTabCubit(): super(RecipesStarted());

  Future<void> getRecipesAndTrigger(int count) async{
    
    emit(RecipesLoading());

    try {
      List<Recipe> recipes = await RecipesDaoRepository().getRandomRecipesWithCount(count);

      if(recipes.isNotEmpty){
        emit(RecipesLoaded(recipe: recipes));
      }
      else{
        emit(RecipesError(errorMessage: "empty list"));
      }

    } catch (e) {
      emit(RecipesError(errorMessage: "tarif verileri yüklenirken hata meydana geldi"));
    }

  }

 
}