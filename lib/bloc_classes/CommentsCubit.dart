
import '../classes/comment.dart';

abstract class CommentsState{
  CommentsState();
}


class CommentsStarted extends CommentsState{
  CommentsStarted();
}

class CommentsLoading extends CommentsState{
  CommentsLoading();
}

class CommentsLoaded extends CommentsState{
  List<Comment> data;
  CommentsLoaded({required this.data});
}

class CommentsError extends CommentsState {
  String errorMessage;

  CommentsError({
    required this.errorMessage,
  });
  
}


