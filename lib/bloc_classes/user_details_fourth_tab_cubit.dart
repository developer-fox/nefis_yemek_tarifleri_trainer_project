import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/PostsState.dart';
import 'package:nefis_yemek_tarifleri/classes/post.dart';

import '../classes/post.dart';


class UserDetailsFourthTabCubit extends Cubit<PostState>{

  UserDetailsFourthTabCubit() : super(PostStarted());


  Future<void> getRecipesAndTrigger(int count) async{

    emit(PostLoading());

    try {
      var data = await getRandomPost(count: count);
      emit(PostLoaded(data: data));


    } catch (e) {
      emit(PostError(errorMessage: "gönderi verileri yüklenirken hata meydana geldi"));
    }

  }


}

