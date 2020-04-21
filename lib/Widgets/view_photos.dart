import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ViewPhotos extends StatefulWidget {
  final String imgPath;
  ViewPhotos(this.imgPath);

  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
  var filePath;
  final String imgShare = "Image.file(File(widget.imgPath),)";

  final LinearGradient backgroundGradient = new LinearGradient(
    colors: [
      Color(0x00000000),
      Color(0x00333333),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.indigo,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: widget.imgPath,
                child: Image.file(
                  File(widget.imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.save),
        onPressed: () async {
          _onLoading(true);

          Uri myUri = Uri.parse(widget.imgPath);
          File originalImageFile = new File.fromUri(myUri);
          Uint8List bytes;
          await originalImageFile.readAsBytes().then((value) {
            bytes = Uint8List.fromList(value);
            print('reading of bytes is completed');
          }).catchError((onError) {
            print('Exception Error while reading audio from path:' +
                onError.toString());
          });
          final result =
              await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));
          print(result);
          _onLoading(false);
          Fluttertoast.showToast(
            msg: "Image Saved",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
      ),
    );
  }
}
