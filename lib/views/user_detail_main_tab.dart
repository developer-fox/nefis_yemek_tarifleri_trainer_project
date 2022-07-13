








import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nefis_yemek_tarifleri/bloc_classes/user_details_first_tab_cubit.dart';
import 'package:nefis_yemek_tarifleri/views/recipe_detail_main_tab.dart';

import '../bloc_classes/PostsState.dart';
import '../bloc_classes/randomImageState.dart';
import '../bloc_classes/recipesState.dart';
import '../bloc_classes/user_details_fourth_tab_cubit.dart';
import '../bloc_classes/user_details_second_tab_cubit.dart';
import '../bloc_classes/user_details_third_tab_cubit.dart';
import '../classes/randomText.dart';
import '../classes/randomTextDaoRepository.dart';
import '../classes/user.dart';
import '../default.dart';

class UserDetailMainTabPage extends StatefulWidget {

  User user;
  UserDetailMainTabPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserDetailMainTabPage> createState() => _UserDetailMainTabPageState();
}

class _UserDetailMainTabPageState extends State<UserDetailMainTabPage> {

  int randomRecipeNoteBookCount = Default.getRandomNumber(0, 5);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserDetailsFirstTabCubit>().getRecipesAndTrigger(Default.getRandomNumber(0, 100));
    context.read<UserDetailsSecondTabCubit>().getRecipesAndTrigger(Default.getRandomNumber(0, 100));
    context.read<UserDetailsThirdTabCubit>().getRandomImagesAndTrigger(Default.getRandomNumber(0, 100), widget.user);
    context.read<UserDetailsFourthTabCubit>().getRecipesAndTrigger(randomRecipeNoteBookCount*3);
  }



  // tabbar widget
  TabBar get _getTabBar =>  TabBar(
    isScrollable: true,
    indicatorWeight: 3,
    indicatorColor: Colors.orange,
    unselectedLabelColor: Colors.grey,
    labelColor: Colors.orange,
    tabs: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,),
        child: Text("TARİFLER"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text("POPÜLER TARİFLER"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text("FOTOĞRAFLAR"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,),
        child: Text("TARİF DEFTERİ"),
      ),
    ],
  );


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: ((context, innerBoxIsScrolled) {
            return <Widget>[
            SliverAppBar(
              backgroundColor: Default.default_red,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Icon(Icons.search, color:  Colors.white, size: 32,),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Icon(Icons.share, color:  Colors.white,  size: 32),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.settings, color:  Colors.white,  size: 32),
                ),
              ],
              pinned: true,
              expandedHeight: 320,
              flexibleSpace: FlexibleSpaceBar(
                
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                  
                    Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6qAPHygon7o5G2RX28z04Jxr4wSq8biDP-g&usqp=CAU", fit: BoxFit.fill,colorBlendMode: BlendMode.srcOver, color: Color.fromARGB(146, 12, 12, 12),),
                  
                    Padding(
                      padding:  EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left:16,),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(widget.user.imageUrl),
                                      radius: Default.scaleWithScreen(context, 10).width,
                                    ),
                                    Text(widget.user.name, style: TextStyle(color: Colors.white),), 
                                  ],
                                ),
                              ),
                  
                              SizedBox(
                                width: Default.scaleWithScreen(context, 60).width,
                                child: Padding(
                                  padding: EdgeInsets.only(right: Default.scaleWithScreen(context, 5).width),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(Default.getRandomNumber(0, 20).toString(), style: TextStyle(color: Colors.white, fontSize: 16),),
                                              Text("Tarif", style: TextStyle(color: Colors.white, fontSize: 16))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(Default.getRandomNumber(0, 4000).toString(), style: TextStyle(color: Colors.white, fontSize: 16)),
                                              Text("Takipçi", style: TextStyle(color: Colors.white, fontSize: 16))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(Default.getRandomNumber(0, 4000).toString(), style: TextStyle(color: Colors.white, fontSize: 16)),
                                              Text("Takip", style: TextStyle(color: Colors.white, fontSize: 16))
                                            ],
                                          ),
                                        ],
                                      ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: SizedBox(
                                                width: Default.scaleWithScreen(context, 60).width,
                                                child: TextButton(
                                                  child: Text("+ Takip Et", style: TextStyle(color: Colors.white, fontSize: 20)),
                                                  onPressed: (){},
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Default.default_red,
                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                                    padding: EdgeInsets.symmetric(vertical: 16, )
                                                  ),
                                                ),
                                              ),
                                            ),                                
                                    ],
                                  ),
                                ),
                              )
                  
                  
                            ],
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 16, top: 10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("lorem ipsum dolor sit amet, consectetur adipiscing elit", style: TextStyle(color: Colors.white, fontSize: 14,))),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on_outlined, color: Colors.white, size: 32,),
                                      Text(widget.user.location, style: TextStyle(color: Colors.white, fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                  
                        ],
                      ),
                    ),
                  
                  
                  ],
                ),
              ),
              bottom:
                PreferredSize(
                  child:  Material(
                    color: Colors.white,
                    child: _getTabBar,
                  ),
                  preferredSize: _getTabBar.preferredSize,

                )
              ),

            ];
          
          

          }),

          body: TabBarView(
            children: [
              UserDetailsFirstRecipesTab(currentUser: widget.user,),
              UserDetailsSecondRecipesTab(),
              UserDetailsThirdRandomImagesTab(),
              UserDetailsFourthRecipesNotebookTab(),
            ],
          ),
          ),
      ) 
    
        
    
      
    );  
  }
}




// first tab
class UserDetailsFirstRecipesTab extends StatefulWidget {
  User currentUser;
  UserDetailsFirstRecipesTab({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<UserDetailsFirstRecipesTab> createState() => _UserDetailsFirstRecipesTabState();
}

class _UserDetailsFirstRecipesTabState extends State<UserDetailsFirstRecipesTab> {
  @override
  Widget build(BuildContext context) {
  
    return BlocBuilder<UserDetailsFirstTabCubit, RecipesState>(
      builder: (context, state) {
        
        if(state is RecipesLoaded){
          return GridView.builder(
            gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 10/9,
            ),
            itemCount: state.recipe.length ,
            itemBuilder: (context, index){
              return TextButton(
                onPressed:(){
                   Navigator.push(context, MaterialPageRoute(builder: ((context)=> RecipeDetailPage(author: widget.currentUser, recipe: state.recipe[index]))));
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.network(state.recipe[index].recipeImageUrl, fit: BoxFit.fitWidth,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                            color: Colors.white,
                            child: Text(state.recipe[index].recipeName.split(" ").length<= 2 ? state.recipe[index].recipeName : state.recipe[index].recipeName.split(" ")[0] +" " + state.recipe[index].recipeName.split(" ")[1]+"...", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                          ),
                      ),
                    ],
                  ),
                ),
              );
            }
          );
        }
        else if(state is RecipesLoading){
          return CircularProgressIndicator();
        }
        else if(state is RecipesError){

          if(state.errorMessage == "empty list"){
            return Text("veritabani bos liste dondurdu");
          }
          else{
            return Text(state.errorMessage);
          }
          
        }
        else{
          return Text("undefined error");
        }

      },
    );


  }
}



// second tab
class UserDetailsSecondRecipesTab extends StatefulWidget {
  const UserDetailsSecondRecipesTab({Key? key}) : super(key: key);

  @override
  State<UserDetailsSecondRecipesTab> createState() => _UserDetailsSecondRecipesTabState();
}

class _UserDetailsSecondRecipesTabState extends State<UserDetailsSecondRecipesTab> {
  @override
  Widget build(BuildContext context) {
  
    return BlocBuilder<UserDetailsSecondTabCubit, RecipesState>(
      builder: (context, state) {
        
        if(state is RecipesLoaded){
          return GridView.builder(
            gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 10/9,
            ),
            itemCount: state.recipe.length ,
            itemBuilder: (context, index){
              return Card(
                child: Column(
                  children: [
                    Image.network(state.recipe[index].recipeImageUrl, fit: BoxFit.fitWidth,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                          color: Colors.white,
                          child: Text(state.recipe[index].recipeName.split(" ").length <=2 ? state.recipe[index].recipeName : state.recipe[index].recipeName.split(" ")[0] + " " + state.recipe[index].recipeName.split(" ")[1]+ "...", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                        ),
                    ),
                  ],
                ),
              );
            }
          );
        }
        else if(state is RecipesLoading){
          return CircularProgressIndicator();
        }
        else if(state is RecipesError){

          if(state.errorMessage == "empty list"){
            return Text("veritabani bos liste dondurdu");
          }
          else{
            return Text(state.errorMessage);
          }
          
        }
        else{
          return Text("undefined error");
        }

      },
    );


  }
}



// third tab
class UserDetailsThirdRandomImagesTab extends StatefulWidget {
  const UserDetailsThirdRandomImagesTab({Key? key}) : super(key: key);

  @override
  State<UserDetailsThirdRandomImagesTab> createState() => _UserDetailsThirdRandomImagesTabState();
}

class _UserDetailsThirdRandomImagesTabState extends State<UserDetailsThirdRandomImagesTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsThirdTabCubit, RandomImageState>(
      builder: (context, state) {
        
        if(state is RandomImageLoaded){

          if(state.data.length ==0){
            return Text("hiç fotoğraf yok");
          }
          else{
            return GridView.builder(
              gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 10/8,
              ),
              itemCount: state.data.length ,
              itemBuilder: (context, index){
                return Card(
                  child: Image.network(state.data[index].imageUrl, fit:  BoxFit.fitHeight,),
                );
              }
            );
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

      },
    );

  }
}



// fourth tab
class UserDetailsFourthRecipesNotebookTab extends StatefulWidget {
  const UserDetailsFourthRecipesNotebookTab({Key? key}) : super(key: key);

  @override
  State<UserDetailsFourthRecipesNotebookTab> createState() => _UserDetailsFourthRecipesNotebookTabState();
}

class _UserDetailsFourthRecipesNotebookTabState extends State<UserDetailsFourthRecipesNotebookTab> {
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<UserDetailsFourthTabCubit, PostState>(
      builder: ((context, state) {
        
        if(state is PostLoaded){
          
          if(state.data.isEmpty == false){
            var cardCount = (state.data.length/3).floor();
            return GridView.builder(
              
              itemCount: cardCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 1
              ),
              itemBuilder: (context, index){
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Default.scaleWithScreen(context,6).width,
                      width: Default.scaleWithScreen(context,38).width,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Tarif Defteri", style: TextStyle( fontSize: 16))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Default.scaleWithScreen(context, 25).width,
                          child: Image.network(state.data[index*1].recipe.recipeImageUrl, fit: BoxFit.fitWidth,)),
                        Column(
                          children: [
                            SizedBox(
                              width: Default.scaleWithScreen(context, 12.5).width,
                              child: Image.network(state.data[index*2].recipe.recipeImageUrl, fit: BoxFit.fitWidth,)),
                            SizedBox(
                              width: Default.scaleWithScreen(context, 12.5).width,
                              child: Image.network(state.data[index*3].recipe.recipeImageUrl, fit: BoxFit.fitWidth,)),
                          ]
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      height: Default.scaleWithScreen(context, 6).width,
                      width: Default.scaleWithScreen(context,38).width,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("(3)", style: TextStyle(fontSize: 16)))),
                ],
                );
              },
            );
          }
          else{
            return Text("bos liste dondu");
          }

        }
        else if(state is PostLoading){
          return Center(child: CircularProgressIndicator());
        }
        else if(state is PostError){
          return Text(state.errorMessage);
        }
        else{
          return Text("undefined error");
        }

      }),
    );

  }
}

