
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nefis_yemek_tarifleri/bloc_classes/carousel_slide_photos_state.dart';
import 'package:nefis_yemek_tarifleri/default.dart';
import 'package:nefis_yemek_tarifleri/views/recipe_detail_main_tab.dart';
import 'user_detail_main_tab.dart';
import '../bloc_classes/PostsCubit.dart';
import '../bloc_classes/PostsState.dart';
import '../bloc_classes/carousel_slide_dots_cubit.dart';
import '../bloc_classes/carousel_slide_photos_cubit.dart';
import '../classes/recipeCard.dart';

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {

  CarouselController radioButtonsCarouselController = CarouselController();

   @override
  void initState() {
    super.initState();
  }

  var inPageTabWidgets = [GridViewSixPost(), GridViewSixPost(), GridViewSixPost()];

  int inPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
                  children: [


                    // carousel slider 
                    BlocBuilder<CarouselSlidePhotosCubit, CarouselSlidePhotosState>(
                      builder: ((context, state) {
                        
                        if(state is CarouselSlidePhotosLoaded){
                            return Stack(
                            children:[ 

                              CarouselSlider(
                              carouselController: radioButtonsCarouselController,
                              items: state.dataResponse.map((e) {
                                return Stack(
                                  children: [

                                    GestureDetector(
                                      child: Image.network(
                                        e.recipe.recipeImageUrl,
                                        fit: BoxFit.fitWidth,
                                        width: Default.scaleWithScreen(context, 100).width,
                                        cacheWidth: Default.scaleWithScreen(context, 100).width.toInt(),
                                        ),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: ((context)=> RecipeDetailPage(author: e.user, recipe: e.recipe,))));
                                      },
                                      ),
                          
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                          left: Default.scaleWithScreen(context, 1).width,
                                          bottom: Default.scaleWithScreen(context, 2).width),
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: ((context)=> UserDetailMainTabPage(user: e.user,))));
                                          },
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              CircleAvatar(
                                                radius: Default.scaleWithScreen(context,7).width,
                                                backgroundImage: NetworkImage(e.user.imageUrl),),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                  left: Default.scaleWithScreen(context,1).width,
                                                  bottom: Default.scaleWithScreen(context,2.5).width
                                                  ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(e.recipe.recipeName.split(" ").length <=3 ? e.recipe.recipeName : e.recipe.recipeName.split(" ")[0] + " " + e.recipe.recipeName.split(" ")[1] +" " +e.recipe.recipeName.split(" ")[2] +"...", style: const TextStyle(fontSize: 16, color: Colors.white)),
                                                    Text("@${e.user.name}", style: const TextStyle(fontSize: 13, color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                          
                                  ]
                                );
                              }).toList(),
                          
                              options: CarouselOptions(
                                viewportFraction: 1,
                                aspectRatio: 10/6.65,
                                enableInfiniteScroll: false,
                                pauseAutoPlayInFiniteScroll: true,
                                autoPlay: true,
                                autoPlayInterval:const Duration(seconds: 2),
                                autoPlayAnimationDuration: const Duration(milliseconds: 300),
                                autoPlayCurve: Curves.linearToEaseOut,
                                initialPage: 0,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, reason){
                                  context.read<CarouselSlideDotsCubit>().setIndexAndTrigger(index);
                                }
                              ),
                          
                            ),

                            // carousel slider dots widget
                            BlocBuilder<CarouselSlideDotsCubit,int>(
                                builder: (context, count){
                                  return Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DotsIndicator(
                                        dotsCount: state.dataResponse.length,
                                        position: count.toDouble(),
                                        decorator: const DotsDecorator(
                                          spacing: const EdgeInsets.symmetric(horizontal: 3, vertical:4),
                                          color: const Color.fromARGB(122, 43, 41, 41),
                                          activeColor: const Color.fromARGB(221, 255, 255, 255)
                                        ),
                                        onTap: (index){
                                          radioButtonsCarouselController.jumpToPage(index.toInt());
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ] 
                          );
                        }

                        else if(state is CarouselSlidePhotosLoading){
                          return const CircularProgressIndicator();
                        }
                        else if(state is CarouselSlidePhotosError){
                          return Text(state.errorMessage);
                        }
                        else{
                          return const Text("undefined error");
                        }



                      }),
                    ),


                    // top button menu
                    Column(
                      children: [
                        Stack(
                          children:[
                            Container(
                              color: Default.default_red,
                              width: Default.scaleWithScreen(context, 100).width,
                              height: 80,
                            ), 
                            SizedBox(
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MainTextButton(buttonIcon:  Icons.flatware, buttonText: "TARİFLER"),
                                VerticalDivider(color: Colors.white, thickness: 2, indent: 10, endIndent: 10, width: 1,),
                                MainTextButton(buttonIcon:  Icons.slow_motion_video_sharp, buttonText: "VİDEOLAR"),
                                VerticalDivider(color: Colors.white, thickness: 2, indent: 10, endIndent: 10, width: 1,),
                                MainTextButton(buttonIcon:  Icons.menu_book_rounded, buttonText: "MENÜLER"),
                                VerticalDivider(color: Colors.white, thickness: 2, indent: 10, endIndent: 10, width: 1,),
                                MainTextButton(buttonIcon:  Icons.local_fire_department_outlined, buttonText: "TREND"),
                              ],
                            ),
                          ),
                          ] 
                        ),
                        Stack(children: [
                          Divider(color: Default.default_red, thickness: 1.2, height: 1,),
                          Divider(color: Colors.white, thickness: 1.2, height: 1, indent: 10,endIndent: 10,)
                        ]),
                        Stack(
                          children:[
                            Container(
                              color: Default.default_red,
                              width: Default.scaleWithScreen(context, 100).width,
                              height: 80,
                            ), 
                            SizedBox(
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MainTextButton(buttonIcon:  Icons.book_outlined, buttonText: "BLOG"),
                                VerticalDivider(color: Colors.white, thickness: 2, indent: 10, endIndent: 10, width: 1,),
                                MainTextButton(buttonIcon:  Icons.list_alt_outlined, buttonText: "LİSTELER"),
                                VerticalDivider(color: Colors.white, thickness: 2, indent: 10, endIndent: 10, width: 1,),
                                MainTextButton(buttonIcon:  Icons.icecream_outlined, buttonText: "KAÇ KALORİ"),
                                VerticalDivider(color: Colors.white, thickness: 2, indent: 10, endIndent: 10, width: 1,),
                                MainTextButton(buttonIcon:  Icons.fastfood_outlined, buttonText: "NE PİŞİRSEM?"),
                              ],
                            ),
                          ),
                          ] 
                        ),
                      ],
                    ),


                    // in-page tabBar
                    Container(
                      height: 100,
                      color: Colors.grey.shade300,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          color: Colors.white,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 50,
                                width: Default.scaleWithScreen(context, 25).width,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      inPageIndex = 0;
                                    });
                                  }, child: 
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("En Yeni", style: TextStyle(color: inPageIndex == 0 ? Default.default_red : Colors.grey)),
                                      Text("TARİFLER",style: TextStyle(color: inPageIndex == 0 ?  Default.default_red : Colors.grey) ),
                                    ],
                                  )),
                              ),
                              VerticalDivider(thickness: 1, color: Colors.grey, indent: 6, endIndent: 6,),
                              SizedBox(
                                height: 50,
                                width: Default.scaleWithScreen(context, 25).width,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      inPageIndex =1;
                                    });
                                  },
                                  child: 
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("En Yeni",  style: TextStyle(color: inPageIndex == 1 ? Default.default_red : Colors.grey),  ),
                                      Text("VİDEOLAR", style: TextStyle(color: inPageIndex == 1 ?  Default.default_red : Colors.grey)),
                                    ],
                                  )),
                              ),
                              VerticalDivider(thickness: 1, color: Colors.grey, indent: 6, endIndent: 6,),
                              SizedBox(
                                height: 50,
                                width: Default.scaleWithScreen(context, 25).width,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: (){
                                    setState( () {
                                      inPageIndex =2;
                                    });
                                  }, child: 
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("En Yeni", style: TextStyle(color: inPageIndex == 2 ? Default.default_red : Colors.grey)),
                                      Text("MENÜLER", style: TextStyle(color: inPageIndex == 2 ?  Default.default_red : Colors.grey)),
                                    ],
                                  )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),


                    // recipes ||  videos || menus
                    inPageTabWidgets[inPageIndex],


                  ],
          ),
    );
  }
}




// Top menu button class
class MainTextButton extends StatefulWidget {

  IconData buttonIcon;
  String buttonText;
  MainTextButton({
    Key? key,
    required this.buttonIcon,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<MainTextButton> createState() => _MainTextButtonState();
}

class _MainTextButtonState extends State<MainTextButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Default.scaleWithScreen(context, 24.8).width,
      child: TextButton(onPressed: (){},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Default.default_red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(widget.buttonIcon, color: Default.default_orange, size: 28,),
                ),
                Text(widget.buttonText, style: TextStyle(color: Colors.white),),
              ],
            ),
          ) ,
    );
  }
}


// gridView 6 post 
class GridViewSixPost extends StatefulWidget {
  const GridViewSixPost({Key? key}) : super(key: key);

  @override
  State<GridViewSixPost> createState() => _GridViewSixPostState();
}

class _GridViewSixPostState extends State<GridViewSixPost> {
  @override
  Widget build(BuildContext context) {
                      return  BlocBuilder<PostsCubit, PostState>(
                      
                      builder: (BuildContext context, snapshot) {

                        if(snapshot is PostLoaded){
                          return GridView.builder(
                            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, 
                              childAspectRatio: 10/12,
                            ),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){
                              return RecipeCardWidget(post: snapshot.data[index] );
                            }
                          );
                        }

                        else if(snapshot is PostLoading){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else if(snapshot is PostError){
                          return Text(snapshot.errorMessage);
                        }
                        else{
                          return const Text("Undefined Error");
                        }
                      },

                    );
  }
}
