
import '../classes/post.dart';

abstract class SimilarRecipesState{
  SimilarRecipesState();
}


class SimilarRecipesStarted extends SimilarRecipesState{
  SimilarRecipesStarted();
}

class SimilarRecipesLoading extends SimilarRecipesState{
  SimilarRecipesLoading();
}

class SimilarRecipesLoaded extends SimilarRecipesState{
  List<Post> data;
  SimilarRecipesLoaded({required this.data});
}

class SimilarRecipesError extends SimilarRecipesState {
  String errorMessage;

  SimilarRecipesError({
    required this.errorMessage,
  });
  
}


