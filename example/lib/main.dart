import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_barcode.dart';
import 'barcode_details.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new HomePage());
}

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Barcode> qr = List<Barcode>();
  bool camState = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Plugin example app'),
      ),
      body: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            camState
                ? new SizedBox(
                    width: 300.0,
                    height: 500.0,
                    child: new QrCamera(
                      onError: (context, error) => Text(
                        error.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      qrCodeCallback: (code) {
                        setState(() {
                          qr = code;
                        });
                      },
                      child: new Container(
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.orange, width: 10.0, style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  )
                : Expanded(child: new Center(child: new Text("Camera inactive"))),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 2,
                    );
                  },
                  itemCount: qr.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BarCodeDetails(
                                    barcode: qr[index],
                                  )),
                        );
                      },
                      title: Text(
                        qr[index].displayValue,
                      ),
                      subtitle: Text(qr[index].valueType.index == 1
                          ? 'Contact Info'
                          : qr[index].valueType.index == 2
                              ? 'Email'
                              : qr[index].valueType.index == 3
                                  ? 'ISBN'
                                  : qr[index].valueType.index == 4
                                      ? 'Phone'
                                      : qr[index].valueType.index == 5
                                          ? 'Product'
                                          : qr[index].valueType.index == 6
                                              ? 'SMS'
                                              : qr[index].valueType.index == 7
                                                  ? 'Text'
                                                  : qr[index].valueType.index == 8
                                                      ? 'URL'
                                                      : qr[index].valueType.index == 9
                                                          ? 'WIFI'
                                                          : qr[index].valueType.index == 10
                                                              ? 'Geographic Coordinates'
                                                              : qr[index].valueType.index == 11
                                                                  ? 'Calendar Event'
                                                                  : qr[index].valueType.index == 12
                                                                      ? 'Driving Licence'
                                                                      : ''),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Text(
            "press me",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            setState(() {
              camState = !camState;
            });
          }),
    );
  }
}
