
import 'package:flutter/material.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/randomImageCubit.dart';
import 'package:nefis_yemek_tarifleri/classes/recipeCard.dart';

import 'package:nefis_yemek_tarifleri/views/recipe_comments_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nefis_yemek_tarifleri/views/recipe_samplers_photos_tab.dart';
import 'package:nefis_yemek_tarifleri/views/user_detail_main_tab.dart';
import '../bloc_classes/CommentsState.dart';
import '../bloc_classes/SimilarRecipesCubit.dart';
import '../bloc_classes/SimilarRecipesState.dart';
import '../bloc_classes/randomImageCubit.dart';
import '../bloc_classes/randomImageState.dart';
import '../classes/recipe.dart';
import '../classes/user.dart';
import '../default.dart';

class RecipeDetailPage extends StatefulWidget {
  
  User author;
  Recipe recipe;
  late int randomCommentsCount;
  late int randomOtherTriedsImageCount;
  RecipeDetailPage({
    Key? key,
    required this.author,
    required this.recipe,
  }){
    randomCommentsCount = Default.getRandomNumber(0,25);
    randomOtherTriedsImageCount = Default.getRandomNumber(0,30);
  } 
  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<RandomImageCubit>().GetRandomImagesAndTrigger(Default.getRandomNumber(0, 12));
    context.read<RandomImageCubit2>().GetRandomImagesForOtherSamplersAndTrigger(widget.randomOtherTriedsImageCount);
    context.read<CommentsCubit>().getCommentsWithCountAndTrigger(widget.randomCommentsCount);
    context.read<SimilarRecipesCubit>().getSimilarRecipesAndTrigger(widget.recipe.recipeId);
  }

  TabBar get _getTabBar => TabBar(
    labelColor: Colors.orange,
    unselectedLabelColor: Colors.grey.shade400,
    indicatorColor: Colors.orange,
    tabs: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 30,
          child: Center(child: Text("TARİFLER", style: TextStyle(fontSize: 14),))),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 30,
          child: Center(child: Text("YORUMLAR", style: TextStyle( fontSize: 14),))),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 30,
          child: Center(child: Text("DENEYENLER", style: TextStyle( fontSize: 14),))),
      ),


    ],
  );


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        
        appBar: AppBar(
          backgroundColor: Default.default_red,
          actions: [
            Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.note_alt_outlined, size: 36,),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.bakery_dining_outlined, size: 36,),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.chat_bubble, size: 36,),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.share, size: 36,),
              ),
            ],)
          ],
          bottom: PreferredSize(
            preferredSize: _getTabBar.preferredSize,
            child: Material(
              color: Colors.white,
              child: _getTabBar,
            ),
          ),
        ),
    
        body: TabBarView(
          children: [
            RecipeTab(author: widget.author, recipe: widget.recipe, randomCommentsCount: widget.randomCommentsCount, randomOtherTriedsImageCount: widget.randomOtherTriedsImageCount,),
            RecipeCommentsTab(commentsCount: widget.randomCommentsCount),
            RecipeSampleresPhotosTab(photosCount: widget.randomOtherTriedsImageCount,),
    
          ],
        ),
        
      ),
    );

  }
}



class RecipeTab extends StatefulWidget {
  User author;
  Recipe recipe;
  int randomCommentsCount;
  int randomOtherTriedsImageCount;

  RecipeTab({
    required this.author,
    required this.recipe,
    required this.randomCommentsCount,
    required this.randomOtherTriedsImageCount,

  });


  @override
  State<RecipeTab> createState() => _RecipeTabState();
}

class _RecipeTabState extends State<RecipeTab> {

  List<Widget> starsRowChildren = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        for(int i=0; i< widget.recipe.stars; i++){
      starsRowChildren.add(Icon(Icons.star, color: Colors.orange[700], size: 28,));
    }
    for(int i=0; i< 5- widget.recipe.stars; i++){
      starsRowChildren.add(Icon(Icons.star_border_sharp, color: Colors.grey, size: 28,));
    }
  }


  @override
  Widget build(BuildContext context) {

    return  SingleChildScrollView(
      child: Column(
            children: [

              // recipe image
              Image.network(
                  widget.recipe.recipeImageUrl,
                  fit: BoxFit.fitWidth,
                  ),

              // recipe name
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:  EdgeInsets.only(left: 10, top: 10),
                  child: Text(widget.recipe.recipeName, style: TextStyle(fontSize: 20),),
                )
                ),
        

              // stars
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Row(
                  children: starsRowChildren,
                ),
              ),
        
              // author details and likes
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: ((context)=> UserDetailMainTabPage(user: widget.author))));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.author.imageUrl),
                            radius: Default.scaleWithScreen(context, 5.8).width,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(widget.author.name, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                          ),
                        ]
                        ,),
                    ),
        
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star_border_outlined, size: 28,),
                            Text("Deftere ekle", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4.5).width,),),
                          ],
                        ),
        
                        Text(widget.recipe.likes.toString() + " kişinin defterinde", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey[700]),),
                      ],
                    ),
        
                  ],
                ),
              ),
        

                  // recipe details
                  Container(
                    width: Default.scaleWithScreen(context,100).width,
                    color: Colors.grey[300],
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column( children: [Text("Kaç Kişilik"), Text(widget.recipe.servings.toString())], ),
                                  const VerticalDivider(color:  Color.fromARGB(255, 192, 191, 191), thickness: 1.5,),
                                  Column( children: [Text("Hazırlama"), Text(widget.recipe.readyInMinutes.toString() + "dk")], ),
                                  const VerticalDivider(color:  Color.fromARGB(255, 192, 191, 191), thickness: 1.5,),
                                  Column( children: [Text("Maliyet (1 servis)"), Text(widget.recipe.pricePerServing.toString() + "\$")], ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
        

              // ingredients - steps
              Padding(
                padding: const EdgeInsets.all(10),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Malzemeler", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                    ),
                    Column(
                        children: widget.recipe.ingredients.map((e) {
                          return ListTile(
                            leading: const Icon(Icons.check),
                            title: Text(e.amount.toString() +" " + e.unitLong + " " +e.name),
                          );
                        }).toList(),

                      ),

                      // 
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("Hazırlanışı", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                            ),

                            Column(
                              children: stepsFormatAndReturner(widget.recipe),
                            ),
  
                          ],
                        ),
                      ),


                    ]        
                ),
              ),
        
            // recipe other images
           BlocBuilder<RandomImageCubit,RandomImageState>(
            builder:((context, state) {
              
              if(state is RandomImageLoaded){
                 return Column(
                    children: state.data.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration:  BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200, width: 2),
                          ),
                          child: Image.network(e.imageUrl)
                          ),
                      );
                    }).toList(),
                  );
              }
              else if(state is RandomImageLoading){
                return CircularProgressIndicator();
              }
              else if(state is RandomImageError){
                return Text(state.errorMessage);
              }
              else{
                return Text("undefined error");
              }

            })
           ),


            // comments button
            Container(
              color: Colors.grey.shade300,
              width: Default.scaleWithScreen(context, 100).width,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      )
                    )
                    ),
                  child: Text("Yorumlar (${widget.randomCommentsCount})", style: TextStyle(
                    color: Default.default_red,
                    fontSize: 16
                  ),),
                  onPressed: (){
                    DefaultTabController.of(context)?.animateTo(1);
                  },
                ),
              ),
            ),


            // images from samplers
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text("Deneyenlerden Fotoğraflar", style: TextStyle(fontSize: 18, color: Colors.grey.shade700)),
                ),

                BlocBuilder<RandomImageCubit2, RandomImageState>(
                  builder: ((context, state) {
                    
                    if(state is RandomImageLoaded){

                      if( state.data.isEmpty == false){
                        return Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 10/6,
                              ),
                      
                              itemCount: (state.data.length > 4) ?  4 : state.data.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                      children: [
                                        Image.network(state.data[index].imageUrl,
                                        fit: BoxFit.fitWidth,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:  EdgeInsets.only(bottom: 1),
                                            child: Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 30,
                                                color: Color.fromARGB(94, 0, 0, 0),
                                                child: Text(state.data[index].sender.name,
                                                style: TextStyle( fontSize: Default.scaleWithScreen(context,3).width,
                                                  color: Colors.white,
                                                  
                                                ),
                                                ),
                                              ),
                                            ),
                                          )
                                          ),
                                      ],
                                    ),
                                );
                              },
                      
                              ),
                      
                            // see all photos button
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:4),
                              child: TextButton(onPressed: (){
                                DefaultTabController.of(context)?.animateTo(2);
                              }, 
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Tüm Fotoğrafları Gör", style: TextStyle(color: Colors.grey.shade600, fontSize: 16),),
                                    Icon(Icons.keyboard_arrow_right_outlined, size: 20, color: Colors.grey.shade700),
                                  ],
                                ),
                              ) ),
                            )
                      
                          ],
                        );
                      }
                      else{
                        return Text("İlk Fotoğrafı Sen Gönder");
                      }

                    }
                    else if(state is RandomImageLoading){
                      return CircularProgressIndicator();
                    }
                    else if(state is RandomImageError){
                      return Text(state.errorMessage);
                    }
                    else{
                      return Text("undefined error");
                    }

                  }),
                ),


              ],
            ),


            // send a photo button and similar recipes title
            Container(
              color: Colors.grey.shade300,
              width: Default.scaleWithScreen(context, 100).width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.orange.shade600),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          )
                        )
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo_camera, color: Colors.white, size: 26),
                          Text("  FOTOĞRAF GÖNDER", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                          ),),
                        ],
                      ),
                      onPressed: (){},
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height: 40,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text("Benzer Tarifler", style: TextStyle(color: Colors.grey.shade600, fontSize: 20)),
                      ),
                    )

                  ],
                ),
              ),
            ),            


              // similar recipes
              BlocBuilder<SimilarRecipesCubit, SimilarRecipesState>(
                builder: ((context, state) {
                  
                  if(state is SimilarRecipesLoaded){
                    return GridView.builder(
                     physics: ScrollPhysics(),
                     itemCount: state.data.length,
                     shrinkWrap: true,
                     scrollDirection: Axis.vertical,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       childAspectRatio: 10/12,
                       crossAxisCount: 2,
                     ),
                     itemBuilder: (context, index){
                       return RecipeCardWidget(post: state.data[index]);
                     },
                   );
                  }
                  else if(state is SimilarRecipesLoading){
                    return CircularProgressIndicator();
                  }
                  else if(state is SimilarRecipesError){
                    return Text(state.errorMessage);
                  }
                  else{
                    return Text("undefined error");
                  }

                }),
              ),

            ]
          ),
    );
  }
}


// helper method for printing steps in to recipe details
List<Widget> stepsFormatAndReturner(Recipe recipe){

  List<Widget> result = [];

  for(int i = 0; i < recipe.steps.length; i++){
    result.add(ListTile(title: Text("${i+1}-) ${recipe.steps[i]}"),));
  }

  return result;

}
