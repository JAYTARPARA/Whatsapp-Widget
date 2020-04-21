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
                'Checkout whatsapp widget app https://mastersam.io',
                subject: 'Whatsapp Widget',
              );
            }),
      ],
    );
  }
}
