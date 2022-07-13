
import 'package:flutter/material.dart';

import 'package:nefis_yemek_tarifleri/classes/post.dart';
import 'package:nefis_yemek_tarifleri/views/user_detail_main_tab.dart';

import '../default.dart';
import '../views/recipe_detail_main_tab.dart';

class RecipeCardWidget extends StatefulWidget {
  Post post;
  RecipeCardWidget({
    Key? key,
    required this.post,
  }) : super(key: key);
  

  @override
  State<RecipeCardWidget> createState() => _RecipeCardWidgetState();
}

class _RecipeCardWidgetState extends State<RecipeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
            GestureDetector(
              child: Container(
                child: Image.network(widget.post.recipe.recipeImageUrl,
                fit: BoxFit.fitWidth,
                                                    ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context) => RecipeDetailPage(author: widget.post.user, recipe: widget.post.recipe))));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text( widget.post.recipe.recipeName.split(" ").length <3 ? widget.post.recipe.recipeName : widget.post.recipe.recipeName.split(" ")[0] + " " + widget.post.recipe.recipeName.split(" ")[1] + " " +widget.post.recipe.recipeName.split(" ")[2] +"...", style: TextStyle(fontWeight: FontWeight.w500, fontSize: Default.scaleWithScreen(context, 4).width),),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0, left: 6),
              child: TextButton(
                onPressed: (){ 
                  Navigator.push(context, MaterialPageRoute(builder: ((context)=> UserDetailMainTabPage(user: widget.post.user))));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(widget.post.user.imageUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(widget.post.user.name.length <= 16 ? widget.post.user.name : widget.post.user.name.split(" ")[1], style: TextStyle(color: Colors.grey[600]),),
                      ),
                    
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}



