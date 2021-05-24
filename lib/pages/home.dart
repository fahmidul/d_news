import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_news/helper/hard_coded_data/categoryData.dart';
import 'package:d_news/helper/view_helper/toast.dart';
import 'package:d_news/models/category.dart';
import 'package:d_news/pages/AllNews.dart';
import 'package:d_news/pages/Others.dart';
import 'package:d_news/pages/PopularNews.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State {
  int selectedBottomNavigation = 0;
  List<CategoryModel> categories = List<CategoryModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 30,
              color: Colors.white,
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text("Dnews"),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 80.0,
            margin: EdgeInsets.only(left: 12, right: 12, top: 12),
            // padding: EdgeInsets.only(left: 12, right: 12, top: 12),
            child: ListView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // return getCategory(
                //   imageUrl: categories[index].imageUrl,
                //   categoryName: categories[index].categoryName,
                // ),
                return getCategory(
                    categories[index].imageUrl, categories[index].categoryName);
              },
            ),
          ),
          Expanded(child: buildViewPager())
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "All",
            icon: ImageIcon(
              AssetImage("assets/images/all.png"),
              size: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: "Popular",
            icon: ImageIcon(
              AssetImage("assets/images/popular.png"),
              size: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: "Others",
            icon: ImageIcon(
              AssetImage("assets/images/others.png"),
              size: 24,
            ),
          )
        ],
        currentIndex: selectedBottomNavigation,
        onTap: (index) => {handleBottomItemSelected(index)},
      ),
    );
  }

  Widget getCategory(String imageUrl, String categoryName) {
    return GestureDetector(
      onTap: () {
        showToastInCenter("Coming Soon");
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 170,
                  height: 90,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              width: 170,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildViewPager() {
    return PageView(
      children: [
        KeepAlivePage(child: AllNews()),
        KeepAlivePage(child: PopularNews()),
        KeepAlivePage(child: Others()),
      ],
      onPageChanged: (index) => handlePageChange(index),
      controller: _pageController,
    );
  }

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void handleBottomItemSelected(int selectedBottomItem) {
    setState(() {
      selectedBottomNavigation = selectedBottomItem;
      _pageController.animateToPage(selectedBottomItem,
          duration: Duration(microseconds: 500), curve: Curves.ease);
    });
  }

  void handlePageChange(int i) {
    setState(() {
      selectedBottomNavigation = i;
    });
  }
}

class KeepAlivePage extends StatefulWidget {
  KeepAlivePage({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    /// Dont't forget this
    super.build(context);
    return widget.child;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
