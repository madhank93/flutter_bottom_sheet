import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback _showPersistentBottomSheet;

  @override
  void initState() {
    super.initState();
    _showPersistentBottomSheet = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(
      () {
        _showPersistentBottomSheet = null;
      },
    );

    _scaffoldKey.currentState
        .showBottomSheet(
          (context) {
            return Container(
              color: Colors.redAccent,
              child: Center(
                child: Text("Persistent modal sheet"),
              ),
            );
          },
        )
        .closed
        .whenComplete(
          () {
            if (mounted) {
              setState(
                () {
                  _showPersistentBottomSheet = _showBottomSheet;
                },
              );
            }
          },
        );
  }

  void showModalSheet() {
    showModalBottomSheet(context: context, builder: (_){
      return Container(
        color: Colors.redAccent,
        child: Center(
          child: Text("Modal bottom sheet"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Bottomsheet"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: _showPersistentBottomSheet,
              child: Text('Persistent'),
            ),
            RaisedButton(
              onPressed: showModalSheet,
              child: Text('Modal'),
            )
          ],
        ),
      ),
    );
  }
}
