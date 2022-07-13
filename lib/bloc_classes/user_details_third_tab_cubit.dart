import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/randomImageState.dart';
import 'package:nefis_yemek_tarifleri/classes/randomImage.dart';
import 'package:nefis_yemek_tarifleri/classes/randomImageDaoRepository.dart';

import '../classes/user.dart';



class UserDetailsThirdTabCubit extends Cubit<RandomImageState>{
  UserDetailsThirdTabCubit(): super(RandomImagetarted());

  Future<void>  getRandomImagesAndTrigger(int count, User currentUser) async{

    emit(RandomImageLoading());

    try {
      List<RandomImage> data = await RandomImageDaoRepository().getRandomImagesWithCount(count);

      for (var element in data) { element.sender = currentUser;}

      emit(RandomImageLoaded(data: data));

    } catch (e) {
      emit(RandomImageError(errorMessage: "Fotoğraf verileri yüklenirken hata meydana geldi"));
    }


  }


}

