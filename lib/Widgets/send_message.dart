import 'package:country_code_picker/country_code_picker.dart';
import 'package:dmwa/utils/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class SendMessage extends StatefulWidget {
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  String countryCode = "+91";
  TextEditingController mobile = TextEditingController();
  bool validateMobile = false;

  @override
  void dispose() {
    super.dispose();
    mobile.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Send Message on Whatsapp',
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          20.0,
          0.0,
          20.0,
          0.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Select Country, Enter Number, Click Button and you are done. You don't have to save the number to send message on whatsapp anymore.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Overpass',
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              CountryCodePicker(
                textStyle: TextStyle(
                  fontFamily: 'Overpass',
                ),
                onChanged: _onCountryChange,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: '+91',
                favorite: [
                  '+91',
                  '+1',
                ],
                // optional. Shows only country name and flag
                showCountryOnly: false,
                // optional. Shows only country name and flag when popup is closed.
                showOnlyCountryWhenClosed: false,
                // optional. aligns the flag and the Text left
                alignLeft: false,
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 0.0,
                ),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: mobile,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    labelText: 'Mobile',
                    labelStyle: TextStyle(
                      color: validateMobile ? Colors.red : Colors.white,
                      fontFamily: 'Overpass',
                    ),
                    errorText: validateMobile ? 'Please enter mobile' : null,
                    errorStyle: TextStyle(
                      fontFamily: 'Overpass',
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 0.0,
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            mobile.text.isEmpty
                                ? validateMobile = true
                                : validateMobile = false;
                          });

                          if (!validateMobile) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            print(countryCode);
                            print(mobile.text);
                            var sendTo = countryCode + mobile.text;
                            FlutterOpenWhatsapp.sendSingleMessage(
                              sendTo,
                              "Hi",
                            );
                          }
                        },
                        child: Text(
                          "Send Message".toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'OverpassRegular',
                          ),
                        ),
                        padding: const EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        // color: Theme.of(context).primaryColorLight,
                        color: Theme.of(context).primaryColor,
                        // color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCountryChange(CountryCode code) {
    setState(() {
      countryCode = code.toString();
    });
    print(countryCode);
    // print("New Country selected: " + countryCode.toString());
  }
}
