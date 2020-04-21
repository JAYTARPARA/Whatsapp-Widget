import 'package:dmwa/utils/common.dart';
import 'package:dmwa/utils/video_play.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'package:thumbnails/thumbnails.dart';

final Directory _videoDir =
    new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class VideoScreen extends StatefulWidget {
  @override
  VideoScreenState createState() => new VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory("${_videoDir.path}").existsSync()) {
      return Center(
        child: Text(
          "Install WhatsApp. Your Friend's Status will be available here.",
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Overpass',
          ),
        ),
      );
    } else {
      return VideoGrid(directory: _videoDir);
    }
  }
}

class VideoGrid extends StatefulWidget {
  final Directory directory;

  const VideoGrid({Key key, this.directory}) : super(key: key);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  _getImage(videoPathUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    String thumb = await Thumbnails.getThumbnail(
      videoFile: videoPathUrl,
      imageType: ThumbFormat.PNG, //this image will store in created folderpath
      quality: 20,
    );
    return thumb;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var videoList = widget.directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".mp4"))
        .toList(growable: false);

    if (videoList != null) {
      if (videoList.length > 0) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: Common().getSmartBannerHeight(mediaQuery),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child: GridView.builder(
              itemCount: videoList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // childAspectRatio: 1.0,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new PlayStatus(videoList[index]),
                    ),
                  ),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black87,
                      ),
                      child: FutureBuilder(
                          future: _getImage(videoList[index]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                return Hero(
                                  tag: videoList[index],
                                  child: Image.file(
                                    File(snapshot.data),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return Center(
                                  child: SpinKitWave(
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                );
                              }
                            } else {
                              return Hero(
                                tag: videoList[index],
                                child: Container(
                                  height: 280.0,
                                  child: SpinKitWave(
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        return Center(
          child: Text(
            "Sorry, No Videos Found.",
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Overpass',
            ),
          ),
        );
      }
    } else {
      return Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 30.0,
        ),
      );
    }
  }
}
