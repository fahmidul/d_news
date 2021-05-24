import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:d_news/models/News.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetails extends StatefulWidget {
  final Article article;

  NewsDetails({Key key, this.article}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NewsDetailsState();
  }
}

class NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Wrap(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.article.urlToImage != null
                        ? widget.article.urlToImage
                        : "https://via.placeholder.com/150")),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              widget.article.content,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
