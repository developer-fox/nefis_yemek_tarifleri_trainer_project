
import '../classes/post.dart';
import '../classes/recipe.dart';

abstract class PostState{
  PostState();

}


class PostStarted extends PostState{
  PostStarted();
}

class PostLoading extends PostState{
  PostLoading();
}

class PostLoaded extends PostState{
  List<Post> data;
  PostLoaded({required this.data});
}

class PostError extends PostState {
  String errorMessage;

  PostError({
    required this.errorMessage,
  });
  

}


