import 'package:dmwa/Widgets/download_status.dart';
import 'package:dmwa/Widgets/send_message.dart';
import 'package:dmwa/utils/share.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Whatsapp Widget',
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
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Press again to exit'),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            10.0,
            0.0,
            10.0,
            0.0,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SendMessage();
                        },
                      ),
                    );
                  },
                  elevation: 3.0,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                    ),
                  ),
                  label: Text(
                    "Send Message on Whatsapp".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'OverpassRegular',
                    ),
                  ),
                  // padding: const EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 15.0,
                ),
                RaisedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DownloadStatus();
                        },
                      ),
                    );
                  },
                  elevation: 3.0,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.download,
                      color: Colors.white,
                    ),
                  ),
                  label: Text(
                    "Download Status".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'OverpassRegular',
                    ),
                  ),
                  // padding: const EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
