import 'package:flutter/material.dart';
import 'package:news_app/enums/categories.dart';
import 'package:news_app/services/news_services.dart';
import 'package:news_app/views/news_list_view_builder.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NewsServices.instance.setupNewNews(Categories.general);
  }

  Categories category = Categories.general;
  final images = [
    'assets/general.jpg',
    'assets/entertaiment.jpg',
    'assets/business.jpg',
    'assets/health.jpg',
    'assets/science.jpg',
    'assets/sports.jpg',
    'assets/technology.jpeg',
  ];

  final categories = [
    'General',
    'Entertainment',
    'Business',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];

//second process
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'News',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Cloud',
              style: TextStyle(
                color: Color(0xFFE1B77E),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: categoryList(),
              ),
            ),
            //ملحوظة مهمة في اخر الفايل بخصوص دا
            NewsListViewBuilder()
          ],
        ),
      ),
    );
  }

  Widget categoryList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (context, index) {
        return categoryItem(context, index);
      },
    );
  }

  Widget categoryItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            category = switch (index) {
              2 => Categories.business,
              1 => Categories.entertainment,
              3 => Categories.health,
              4 => Categories.science,
              5 => Categories.sports,
              6 => Categories.technology,
              int() => Categories.general,
            };
            NewsServices.instance.setupNewNews(category);
          });
        },
        child: SizedBox(
          width: 250,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.passthrough,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Text(
                  categories[index],
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// FutureBuilder(

//اللي بيحصل انه بيسمع للبيانات اللي جاية من فيوتشر لو البيانات ديه اتغيرت قالك علطول يروح يعمل اعادة بناء او يرسم من جديد اللي في رقم اتنين

//               future: NewsServices().getGeneralNews(),//حط ودنه مع البيانات اللي جاية تقدر تقول بيسمعها وشغل الفانكشن
//               builder: (context, snapshot/*الداتا اللي بتتغير*/) {

//رقم اتنين

//                 if (snapshot.hasData) {
//                   return newsList(
//                     snapshot.data!,
//                   );
//                 } else if (snapshot.hasError) {
//                   const SliverToBoxAdapter(
//                     child: Center(
//                       child: Text('Oops There\'s an error'),
//                     ),
//                   );
//                 }
//                 return const SliverToBoxAdapter(
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: double.infinity,
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               },
//             )