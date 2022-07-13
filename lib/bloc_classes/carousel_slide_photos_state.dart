

import 'package:nefis_yemek_tarifleri/classes/post.dart';

abstract class CarouselSlidePhotosState{
  CarouselSlidePhotosState();
}


class CarouselSlidePhotosStart extends CarouselSlidePhotosState{
  CarouselSlidePhotosStart();
}


class CarouselSlidePhotosLoading extends CarouselSlidePhotosState{
  CarouselSlidePhotosLoading();
}

class CarouselSlidePhotosLoaded extends CarouselSlidePhotosState{

  List<Post> dataResponse;
  CarouselSlidePhotosLoaded({required this.dataResponse});
}

class CarouselSlidePhotosError extends CarouselSlidePhotosState{
  String errorMessage;
  CarouselSlidePhotosError({required this.errorMessage});
}


