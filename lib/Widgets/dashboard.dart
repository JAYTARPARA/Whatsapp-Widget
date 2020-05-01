import 'package:dmwa/Widgets/image_screen.dart';
import 'package:dmwa/Widgets/video_screen.dart';
import 'package:dmwa/utils/share.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final String type;
  Dashboard(this.type);
  @override
  DashboardState createState() => new DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Download Status',
          style: TextStyle(
            // color: Constants.darkBG,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            fontFamily: 'Overpass',
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          ShareWidget(),
        ],
        bottom: TabBar(tabs: [
          Container(
            height: 30.0,
            child: Text(
              'IMAGES',
              style: TextStyle(
                fontFamily: 'Overpass',
              ),
            ),
          ),
          Container(
            height: 30.0,
            child: Text(
              'VIDEOS',
              style: TextStyle(
                fontFamily: 'Overpass',
              ),
            ),
          ),
        ]),
      ),
      body: TabBarView(
        children: [
          ImageScreen(widget.type),
          VideoScreen(widget.type),
        ],
      ),
    );
  }
}
