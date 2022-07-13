import 'package:flutter_bloc/flutter_bloc.dart';


class CarouselSlideDotsCubit extends Cubit<int>{

  CarouselSlideDotsCubit() : super(0);

  void setIndexAndTrigger(int index){
    emit(index);
  }


}

