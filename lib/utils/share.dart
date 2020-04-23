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
              'Whatsapp Widget Application \r\n https://bit.ly/WAWidget',
              subject: 'Whatsapp Widget',
            );
          },
        ),
      ],
    );
  }
}
