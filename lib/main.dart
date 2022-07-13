
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/CommentsState.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/PostsCubit.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/SimilarRecipesCubit.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/carousel_slide_dots_cubit.dart';
import 'package:nefis_yemek_tarifleri/bloc_classes/carousel_slide_photos_cubit.dart';
import 'package:nefis_yemek_tarifleri/classes/randomImageDaoRepository.dart';
import 'package:nefis_yemek_tarifleri/default.dart';
import 'package:nefis_yemek_tarifleri/views/user_detail_main_tab.dart';
import 'bloc_classes/PostsState.dart';
import 'bloc_classes/randomImageCubit.dart';
import 'bloc_classes/user_details_first_tab_cubit.dart';
import 'bloc_classes/user_details_second_tab_cubit.dart';
import 'bloc_classes/user_details_third_tab_cubit.dart';
import 'classes/recipesDao.dart';
import 'bloc_classes/user_details_fourth_tab_cubit.dart';
import 'views/main_tab.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({Key? key}) : super(key: key);

  // This widget is the root of my application
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      
      providers: [
        BlocProvider(create: (context)=> PostsCubit(accessClass: RecipesDaoRepository())),
        BlocProvider(create: (context)=> RandomImageCubit(accessClass: RandomImageDaoRepository())),
        BlocProvider(create: (context)=> RandomImageCubit2(accessClass: RandomImageDaoRepository())),
        BlocProvider(create: (context)=> CommentsCubit()),
        BlocProvider(create: (context)=> SimilarRecipesCubit()),
        BlocProvider(create: (context)=>CarouselSlideDotsCubit()),
        BlocProvider(create: (context)=>CarouselSlidePhotosCubit()),
        BlocProvider(create: (context)=>UserDetailsFirstTabCubit()),
        BlocProvider(create: (context)=>UserDetailsSecondTabCubit()),
        BlocProvider(create: (context)=>UserDetailsThirdTabCubit()),
        BlocProvider(create: (context)=>UserDetailsFourthTabCubit()),
        
      ],


      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
    context.read<PostsCubit>().GetRecipesAndTrigger(6);
    context.read<CarouselSlidePhotosCubit>().getCarouselSlidePhotosAndTrigger(14);

  }


    // tabBar get method
    TabBar get _getTabBar => TabBar(
      labelColor: Default.default_red,
      unselectedLabelColor: Colors.grey.shade400,
      indicatorColor: Colors.white,
      tabs: [
        Tab(icon: Icon(Icons.home_outlined, size: Default.scaleWithScreen(context, 9).width,),),
        Tab(icon: Icon(Icons.bookmark_add_outlined, size: Default.scaleWithScreen(context, 9).width,),),
        Tab(icon: Icon(Icons.note_alt_outlined, size: Default.scaleWithScreen(context, 9).width,),),
        Tab(icon: Icon(Icons.notifications_none_outlined, size: Default.scaleWithScreen(context, 9).width,),),
      ]
      
      );
 

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Default.default_red,
          title:  const MainTextField(),
          bottom: PreferredSize(
            preferredSize: _getTabBar.preferredSize,
            child: Material(
              color: Colors.white,
              child: _getTabBar),
          ),
        ),
        body:  TabBarView(
          children: [
            MainTab(),
            MainTab(),
            MainTab(),
            MainTab()
          ],
        ),
    
        drawer: const MainDrawer(),
        
      ),
    );
  }
}



// search textfield
class MainTextField extends StatefulWidget {
  const MainTextField({Key? key}) : super(key: key);

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {

  var inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon:const Icon(Icons.search, size: 30, color: Colors.white),

        suffixIcon: const Icon(Icons.mic, color: Colors.white, size:30),
        hintText: "Ara",
        hintStyle: TextStyle(
          fontSize: Default.scaleWithScreen(context,5).width,
          color: Colors.white,
        ),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 1.4)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.4))
      ),
      
      controller: inputController,

    );

  }
}



// drawer
class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    
    return Drawer(

      child:
              ListView(
                children:  [ 

                    //* header
                    Container(
                      height: Default.scaleWithScreen(context, 20).height,
                      color: Default.default_red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    width: 60,
                                    height: 60,
                                  ),

                                Text("User46", style: TextStyle(color: Colors.white, fontSize: Default.scaleWithScreen(context, 3.5).width),),
                                Text("@goog_12874afn1", style: TextStyle(color: Colors.white, fontSize: Default.scaleWithScreen(context, 3.5).width),),
                              ],
                            ),
                            const Icon(Icons.keyboard_arrow_right_outlined, size: 40, color: Colors.white,),
                          ],
                        ),
                      ),
                    ),

                      //* body
                      ListTile(leading: Text("Profilim", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),)),
                      ListTile(leading: Icon(Icons.newspaper),title: Text("Olan Biten", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.speaker_notes_outlined),title: Text("Gelen Yorumlar", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.comment_outlined),title: Text("Yapılan Yorumlar", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.notifications_none_outlined),title: Text("E-Posta ve Bildirim Ayarları", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      Divider(color: Colors.grey,),
                      ListTile(leading: Icon(Icons.fastfood_outlined),title: Text("Bugün Ne Pişirsem?", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.explore_outlined),title: Text("Keşfet", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.switch_access_shortcut),title: Text("Öne Çıkan Tarifler", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.question_mark_sharp),title: Text("Soru-Cevap", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.public_rounded),title: Text("Yazarlar", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.search_rounded),title: Text("Tarif Ara", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      Divider(color: Colors.grey,),
                      ListTile(leading: Text("Kategoriler", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),)),
                      ListTile(leading: Icon(Icons.flatware),title: Text("Tarifler", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.slow_motion_video_sharp),title: Text("Videolar", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.menu_book_rounded),title: Text("Menüler", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.book_outlined),title: Text("Blog", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.list_alt_outlined),title: Text("Listeler", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.icecream_outlined),title: Text("Kaç kalori", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      Divider(color: Colors.grey,),
                      ListTile(leading: Text("Diğer", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),)),
                      ListTile(leading: Icon(Icons.share_outlined),title: Text("Uygulamayı Paylaş", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.favorite_border ),title: Text("Uygulamayı Puanla", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.feedback_outlined ),title: Text("Hata bildir", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.mail_outline_outlined ),title: Text("İletişim", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.query_stats_rounded ),title: Text("Sık Sorulan Sorular", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.content_paste_rounded ),title: Text("Üyelik Sözleşmesi", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.info_outlined ),title: Text("Hakkında", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                      ListTile(leading: Icon(Icons.power_settings_new_rounded),title: Text("Çıkış", style: TextStyle(fontSize: Default.scaleWithScreen(context, 4).width, color: Colors.grey),),),
                ],
              ),
          
        
    );

  }
}


// TabBar
class ProjectTabBar extends StatefulWidget {
  const ProjectTabBar({Key? key}) : super(key: key);

  @override
  State<ProjectTabBar> createState() => _ProjectTabBarState();
}

class _ProjectTabBarState extends State<ProjectTabBar> {
  @override
  Widget build(BuildContext context) {
    
    return TabBar(

      tabs: [
        Icon(Icons.home_outlined),
        Icon(Icons.car_crash),
        Icon(Icons.catching_pokemon_outlined),
      ],

    );

  }
}




