import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nefis_yemek_tarifleri/classes/randomImageDaoRepository.dart';

import 'randomImageState.dart';

class RandomImageCubit extends Cubit<RandomImageState> {

  RandomImageDaoRepository accessClass;

  RandomImageCubit({
    required this.accessClass,
  }): super(RandomImagetarted());


  Future <void> GetRandomImagesAndTrigger(int count) async{

    try {
      emit(RandomImageLoading());

      var dataResponse = await accessClass.getRandomImagesWithCount(count);

      emit(RandomImageLoaded(data: dataResponse));

    } catch (e) {
      String errorMessage = "error occurred while loading images data";
      emit(RandomImageError(errorMessage:errorMessage));
    }


  }


}

class RandomImageCubit2 extends Cubit<RandomImageState> {

  RandomImageDaoRepository accessClass;

  RandomImageCubit2({
    required this.accessClass,
  }): super(RandomImagetarted());



  Future <void> GetRandomImagesForOtherSamplersAndTrigger(int count) async{

    try {
      emit(RandomImageLoading());

      var dataResponse = await accessClass.getRandomImagesWithCount(count);

      emit(RandomImageLoaded(data: dataResponse));

    } catch (e) {
      String errorMessage = "error occurred while loading recipes data";
      emit(RandomImageError(errorMessage:errorMessage));
    }


  }



}

class Cubits{

  static RandomImageCubit recipeOtherImagecCubit = RandomImageCubit(accessClass: RandomImageDaoRepository());
  static RandomImageCubit imagesFromOthersCubit = RandomImageCubit(accessClass: RandomImageDaoRepository());
}

