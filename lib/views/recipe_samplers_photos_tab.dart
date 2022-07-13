
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/randomImageState.dart';
import 'package:nefis_yemek_tarifleri/main.dart';

import '../bloc_classes/randomImageCubit.dart';

class RecipeSampleresPhotosTab extends StatefulWidget {

  int photosCount;
  RecipeSampleresPhotosTab({
    Key? key,
    required this.photosCount,
  }) : super(key: key);


  @override
  State<RecipeSampleresPhotosTab> createState() => _RecipeSampleresPhotosTabState();
}

class _RecipeSampleresPhotosTabState extends State<RecipeSampleresPhotosTab> {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<RandomImageCubit2, RandomImageState>(
      builder: ((context, state) {
        
        if(state is RandomImageLoaded) {

          if(state.data.isEmpty == false){
            return CustomScrollView(
              slivers: [
                SliverGrid(
                delegate: SliverChildListDelegate(
                  state.data.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.6)
                        ),
                        child: Image.network(e.imageUrl)),
                    );
                  }).toList()
                ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1),
                ),
              ],
               
            );            
          }
          else{

            return Text("İlk fotoğrafı siz gönderin.");
          }

        }
        else if(state is RandomImageLoading){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(state is RandomImageError){
          return Text(state.errorMessage);
        }
        else{
          return const Text("undefined error");
        }
      }));


  }
}


