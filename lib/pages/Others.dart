import 'package:d_news/helper/ValidateHelper.dart';
import 'package:d_news/helper/view_helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Others extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OthersState();
  }
}

class OthersState extends State {
  List items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = getItems();
  }

  List getItems() {
    return [
      Items(
          title: "Language",
          subTitle: "Change Language From Here",
          imagePath: "assets/images/language.png"),
      Items(
          title: "Notification",
          subTitle: "Click to Turn On / Off",
          imagePath: "assets/images/notification.png"),
      Items(
          title: "About Us",
          subTitle: "See details about us",
          imagePath: "assets/images/about_us.png"),
      Items(
          title: "Contact Us",
          subTitle: "Just leave a message",
          imagePath: "assets/images/contact_us.png"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: makeBody(items),
    );
  }
}

makeBody(List items) => Container(
      padding: EdgeInsets.only(top: 15, left: 5, right: 5),
      child: ListView.builder(
        // scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(items[index]);
        },
      ),
    );

makeCard(Items item) => Card(
      elevation: 2,
      child: GestureDetector(
        child: makeListTitle(item),
        onTap: () => showToastInCenter("Coming Soon"),
      ),
    );

makeListTitle(Items items) => ListTile(
      leading: Container(
        child: Image.asset(
          items.imagePath,
          width: 30,
          height: 30,
        ),
      ),
      title: Text(ValidateHelper.validateStringData(items.title)),
      subtitle: Text(ValidateHelper.validateStringData(items.subTitle)),
      trailing: Icon(
        Icons.chevron_right,
      ),
    );

class Items {
  String title;
  String subTitle;
  String imagePath;

  Items({this.title, this.subTitle, this.imagePath});
}
