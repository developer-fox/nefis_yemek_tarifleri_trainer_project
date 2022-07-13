
import 'package:flutter_bloc/flutter_bloc.dart';
import '../classes/post.dart';
import 'carousel_slide_photos_state.dart';


class CarouselSlidePhotosCubit extends Cubit<CarouselSlidePhotosState>{

  CarouselSlidePhotosCubit(): super(CarouselSlidePhotosStart());

  Future<void> getCarouselSlidePhotosAndTrigger(int count) async{

    emit(CarouselSlidePhotosLoading());

    try {
      var dataResponse = await getRandomPost(count: count);
      emit(CarouselSlidePhotosLoaded(dataResponse: dataResponse));
    } catch (e) {
      emit(CarouselSlidePhotosError(errorMessage: "Slider verileri yüklenirken hata meydana geldi."));
    }


  }


}




