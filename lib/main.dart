import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What\'s App',
      theme: ThemeData(
          accentColor: Colors.orangeAccent, primaryColor: Colors.orange),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String _num;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.live_help,
              color: Colors.white70,
            ),
            onPressed: () {
              print('tapped');
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Info'),
                      actions: <Widget>[
                        Text(
                          'Send message to any one without\nsaving numbers in contacts',
                          textAlign: TextAlign.justify,
                        )
                      ],
                    );
                  });
            },
          )
        ],
        title: Text(
          "WhatsApp Utility",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        highlightElevation: 10.0,
        child: Icon(
          Icons.send,
          color: Colors.white60,
        ),
        elevation: 15.0,
        onPressed: () {
          _launchURL(_num);
        },
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextField(
                  autofocus: true,
                  onChanged: (v) => _num = v.trim(),
                  decoration: const InputDecoration(
                    fillColor: Colors.orange,
                    suffixIcon: Icon(Icons.phone),
                    labelStyle: TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    labelText: 'Whom to text ?',
                    hintText: 'Enter number to sent text',
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(num) async {
    var url = "https://api.whatsapp.com/send?phone=91" + num;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
