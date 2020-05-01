import 'package:dmwa/Widgets/view_photos.dart';
import 'package:dmwa/utils/common.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageScreen extends StatefulWidget {
  final String type;
  ImageScreen(this.type);
  @override
  ImageScreenState createState() => new ImageScreenState();
}

class ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Directory _photoDir;
    if (widget.type == 'wa') {
      _photoDir = new Directory(Common().photoDirWA);
    } else if (widget.type == 'wab') {
      _photoDir = new Directory(Common().photoDirWAB);
    }

    var mediaQuery = MediaQuery.of(context);
    if (!Directory("${_photoDir.path}").existsSync()) {
      return Center(
        child: Text(
          "Install WhatsApp/WhatsApp Business, Your Friend's Status Will Be Available Here",
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Overpass',
          ),
        ),
      );
    } else {
      var imageList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".jpg"))
          .toList(growable: false);
      if (imageList.length > 0) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: Common().getSmartBannerHeight(mediaQuery),
          ),
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: StaggeredGridView.countBuilder(
              itemCount: imageList.length,
              crossAxisCount: 4,
              itemBuilder: (context, index) {
                String imgPath = imageList[index];
                return Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new ViewPhotos(imgPath),
                        ),
                      );
                    },
                    child: Hero(
                      tag: imgPath,
                      child: Image.file(
                        File(imgPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (i) =>
                  StaggeredTile.count(2, i.isEven ? 2 : 3),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: new Container(
              padding: EdgeInsets.only(
                bottom: 60.0,
              ),
              child: Text(
                'Sorry, No Image Found!',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Overpass',
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}
