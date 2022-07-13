
import '../classes/post.dart';
import '../classes/randomImage.dart';

abstract class RandomImageState{
  RandomImageState();
}


class RandomImagetarted extends RandomImageState{
  RandomImagetarted();
}

class RandomImageLoading extends RandomImageState{
  RandomImageLoading();
}

class RandomImageLoaded extends RandomImageState{
  List<RandomImage> data;
  RandomImageLoaded({required this.data});
}

class RandomImageError extends RandomImageState {
  String errorMessage;

  RandomImageError({
    required this.errorMessage,
  });
  
}


