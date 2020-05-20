import 'dart:io';

import 'package:dmwa/Widgets/download_status.dart';
import 'package:dmwa/Widgets/send_message.dart';
import 'package:dmwa/utils/common.dart';
import 'package:dmwa/utils/share.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:store_redirect/store_redirect.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    initFCM();
  }

  initFCM() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
        provisional: true,
      ),
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("TOKEN: $token");
    });
  }

  Future<bool> _onWillPop() {
    return Alert(
      context: context,
      style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: false,
        titleStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Overpass',
        ),
        descStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Overpass',
        ),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        animationType: AnimationType.fromTop,
      ),
      type: AlertType.warning,
      title: "EXIT APP",
      desc: "Are you sure you want to exit?",
      buttons: [
        DialogButton(
          color: Colors.black87,
          child: Text(
            "No",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Overpass',
            ),
          ),
          onPressed: () => Navigator.of(context).pop(false),
          width: 120,
        ),
        DialogButton(
          color: Colors.black87,
          child: Text(
            "Yes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Overpass',
            ),
          ),
          onPressed: () => exit(0),
          width: 120,
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    FirebaseAdMob.instance.initialize(
      appId: Common().admobAppId,
    );

    BannerAd myBanner = BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      // adUnitId: BannerAd.testAdUnitId,
      adUnitId: Common().bannerUnitId,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {
        // print("BannerAd event is $event");
      },
    );

    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );

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
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.solidStar,
                color: Colors.white,
              ),
              onPressed: () {
                StoreRedirect.redirect(androidAppId: "app.jaytarpara.wawidget");
              },
            ),
          ],
        ),
        actions: <Widget>[
          ShareWidget(),
        ],
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
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
                          return DownloadStatus('wa');
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
                    "Download WhatsApp Status".toUpperCase(),
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
                          return DownloadStatus('wab');
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
                    "Download WA Business Status".toUpperCase(),
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
