
import 'package:bloc/bloc.dart';
import '../classes/commentDaoRepositoy.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/CommentsCubit.dart';

class CommentsCubit extends Cubit<CommentsState> {

  CommentsCubit() : super(CommentsStarted());


  Future <void> getCommentsWithCountAndTrigger(int count) async{
    
    try {
      emit(CommentsLoading());
      var comments = await CommentDaoRepository.getCommentsWithCount(count);
      emit(CommentsLoaded(data: comments));
    } catch (e) {
      var errorMessage = "error occurred while loading images data";

      emit(CommentsError(errorMessage: errorMessage));
  }


  }




}


