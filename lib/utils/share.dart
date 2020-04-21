import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
          ),
          onPressed: () {
            Share.share(
              'Checkout all useful applications \r\n https://play.google.com/store/apps/dev?id=7435506917924983096',
              subject: 'Whatsapp Widget',
            );
          },
        ),
      ],
    );
  }
}
