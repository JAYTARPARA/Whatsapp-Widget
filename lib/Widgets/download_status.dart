import 'package:dmwa/Widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadStatus extends StatefulWidget {
  final String type;
  DownloadStatus(this.type);
  @override
  _DownloadStatusState createState() => _DownloadStatusState();
}

class _DownloadStatusState extends State<DownloadStatus> {
  int _storagePermissionCheck;
  Future<int> _storagePermissionChecker;

  Future<int> checkStoragePermission() async {
    // bool result = await SimplePermissions.checkPermission(Permission.ReadExternalStorage);
    PermissionStatus result = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    print("Checking Storage Permission " + result.toString());
    setState(() {
      _storagePermissionCheck = 1;
    });
    if (result.toString() == 'PermissionStatus.denied') {
      return 0;
    } else if (result.toString() == 'PermissionStatus.granted') {
      return 1;
    } else {
      return 0;
    }
  }

  Future<int> requestStoragePermission() async {
    // PermissionStatus result = await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
    Map<PermissionGroup, PermissionStatus> result =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    if (result.toString() == 'PermissionStatus.denied') {
      return 1;
    } else if (result.toString() == 'PermissionStatus.granted') {
      return 2;
    } else {
      return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    _storagePermissionChecker = (() async {
      int storagePermissionCheckInt;
      int finalPermission;

      print("Initial Values of $_storagePermissionCheck");
      if (_storagePermissionCheck == null || _storagePermissionCheck == 0) {
        _storagePermissionCheck = await checkStoragePermission();
      } else {
        _storagePermissionCheck = 1;
      }
      if (_storagePermissionCheck == 1) {
        storagePermissionCheckInt = 1;
      } else {
        storagePermissionCheckInt = 0;
      }

      if (storagePermissionCheckInt == 1) {
        finalPermission = 1;
      } else {
        finalPermission = 0;
      }

      return finalPermission;
    })();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: FutureBuilder(
        future: _storagePermissionChecker,
        builder: (context, status) {
          if (status.connectionState == ConnectionState.done) {
            if (status.hasData) {
              if (status.data == 1) {
                return Dashboard(widget.type);
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'Storage Permission Required',
                      style: TextStyle(
                        // color: Constants.darkBG,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Overpass',
                      ),
                    ),
                    centerTitle: true,
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Allow Permission".toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'OverpassRegular',
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              _storagePermissionChecker =
                                  requestStoragePermission();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Something went wrong! Please Reinstall App.",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Overpass',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          } else {
            return Scaffold(
              body: Container(
                child: Center(
                  child: SpinKitWave(
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
