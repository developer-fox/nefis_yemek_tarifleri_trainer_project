import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nefis_yemek_tarifleri/classes/post.dart';

import 'package:nefis_yemek_tarifleri/classes/recipesDao.dart';

import 'PostsState.dart';

class PostsCubit extends Cubit<PostState> {

  RecipesDaoRepository accessClass;

  PostsCubit({
    required this.accessClass,
  }): super(PostStarted());


  Future <void> GetRecipesAndTrigger(int count) async{

    try {
      emit(PostLoading());

      var dataResponse = await getRandomPost(count:  count);

      emit(PostLoaded(data: dataResponse));

    } catch (e) {
      String errorMessage = "error occurred while loading recipes data";
      emit(PostError(errorMessage:errorMessage));
    }


  }



}


