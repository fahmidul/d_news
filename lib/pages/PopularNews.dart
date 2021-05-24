import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_news/helper/ValidateHelper.dart';
import 'package:d_news/models/News.dart';
import 'package:d_news/parser/NewsDataParser.dart';
import 'package:flutter/material.dart';

import 'NewsDetails.dart';

class PopularNews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PopularNewsState();
  }
}

class PopularNewsState extends State {
  List<Article> articles = new List();
  bool isDataLoaded = false;

  void loadData() async {
    NewsDataParser newsDataParser = NewsDataParser();
    Future<News> news = newsDataParser.fetchPopularNewsData();
    news.then((value) {
      print(value.articles);
      setState(() {
        articles = value.articles;
        isDataLoaded = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(articles.length);
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    if (!isDataLoaded) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      ));
    } else {
      return Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: articles.length,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true, // add this otherwise an error
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: displayNewsImage(
                          articles[index].urlToImage,
                        )),
                        Padding(padding: EdgeInsets.only(top: 10, right: 10)),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                ValidateHelper.validateStringData(
                                    articles[index].title),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                ValidateHelper.validateStringData(
                                    articles[index].description),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 2,
                          color: Colors.blue,
                        )
                      ],

                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewsDetails(article: articles[index]),
                    ),
                  );
                },
              );
            }),
      );
    }
  }

  Widget displayNewsImage(String imageUrl) {
    if (imageUrl != null) {
      return
        ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              errorWidget: (context, url, error) => Image.asset("assets/images/place_holder.png"),
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ));



    } else {
      return

        ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: "https://via.placeholder.com/150",
              placeholder: (context, url) => CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),

              ),
              errorWidget: (context, url, error) => Image.asset("assets/images/place_holder.png"),
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ));
    }
  }
}
