import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/CommentsCubit.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/CommentsState.dart';
import 'package:nefis_yemek_tarifleri/classes/comment.dart';
import 'package:nefis_yemek_tarifleri/classes/commentDaoRepositoy.dart';

import '../default.dart';

class RecipeCommentsTab extends StatefulWidget {
  int commentsCount;
  
  RecipeCommentsTab({
    Key? key,
    required this.commentsCount,
  }) : super(key: key);
  

  @override
  State<RecipeCommentsTab> createState() => _RecipeCommentsTabState();
}

class _RecipeCommentsTabState extends State<RecipeCommentsTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit,CommentsState>(
      
      builder: (context, snapshot){

        if(snapshot is CommentsLoaded){
          
          if(snapshot.data.isEmpty == false){
            return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: Default.scaleWithScreen(context, 6).width,
                          backgroundImage: NetworkImage(snapshot.data[index].user.imageUrl),
                        ),

                        Container(
                          alignment: Alignment.topLeft,
                          width: Default.scaleWithScreen(context, 85).width,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  snapshot.data[index].user.name),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  snapshot.data[index].content.content),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.favorite),
                                  Text(
                                    textAlign: TextAlign.left,
                                    snapshot.data[index].favs.toString()),    
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: Default.scaleWithScreen(context, 20).width,
                        height: Default.scaleWithScreen(context,5).width,
                        child: ElevatedButton(onPressed: (){}, child: Text("CEVAPLA"))),)
                  ],
                ),
              );
            },
          );
          }
          else{
            return Text("İlk yorumu yapan sen ol.");
          }


        }
        else if(snapshot is CommentsLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapshot is CommentsError){
          return Text(snapshot.errorMessage);
        }
        else{
          return Text("undefined Error");
        }

      }
      
      );
  }
}

