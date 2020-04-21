import 'dart:typed_data';

import 'package:dmwa/utils/common.dart';
import 'package:dmwa/utils/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class PlayStatus extends StatefulWidget {
  final String videoFile;
  PlayStatus(this.videoFile);
  @override
  _PlayStatusState createState() => new _PlayStatusState();
}

class _PlayStatusState extends State<PlayStatus> {
  @override
  void initState() {
    super.initState();
    print('Video file you are looking for:' + widget.videoFile);
  }

  void dispose() {
    super.dispose();
  }

  void _onLoading(bool t) {
    if (t) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: SpinKitWave(
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            );
          });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: Common().getSmartBannerHeight(mediaQuery),
        ),
        child: Container(
          child: StatusVideo(
            videoPlayerController: VideoPlayerController.file(
              File(widget.videoFile),
            ),
            looping: true,
            videoSrc: widget.videoFile,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: Common().getSmartBannerHeight(mediaQuery),
        ),
        child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(Icons.save),
            onPressed: () async {
              _onLoading(true);

              File originalVideoFile = File(widget.videoFile);
              Uint8List bytes;

              await originalVideoFile.readAsBytes().then((value) {
                bytes = Uint8List.fromList(value);
                print('reading of bytes is completed');
              }).catchError((onError) {
                print('Exception Error while reading audio from path:' +
                    onError.toString());
              });
              final result = await ImageGallerySaver.saveFile(widget.videoFile);
              print(result);

              _onLoading(false);

              Fluttertoast.showToast(
                msg: "Video Saved",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }),
      ),
    );
  }
}
