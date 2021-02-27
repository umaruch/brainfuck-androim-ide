import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'ConsolePage.dart';

class CodePage extends StatefulWidget {
  final String filename, code;

  CodePage({this.filename, this.code=""});

  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  final _controller = TextEditingController();
  final _filenameController = TextEditingController();
  bool isFilenameEdit = false;

  @override
  void initState() {
    super.initState();
    _filenameController.text = widget.filename;
    _controller.text = widget.code;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: !isFilenameEdit?Text(_filenameController.text,
            style: Theme.of(context).textTheme.headline3,
            overflow: TextOverflow.ellipsis):TextField(
              style: Theme.of(context).textTheme.bodyText2,
              controller: _filenameController,
            ),
        actions: !isFilenameEdit?<Widget>[
          // Кнопка запуска кода
          IconButton(
            icon: Icon(Icons.play_arrow, size: 28),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          ConsolePage(code: _controller.text)));
            },
          ),
          // Кнопка сохранения
          IconButton(
            icon: Icon(Icons.save, size: 28),
            onPressed: (){
              setState(() {
                isFilenameEdit = true;
              });
              
            },
          ),
        ]:<Widget>[
          IconButton(
            icon: Icon(Icons.cancel, size: 28),
            onPressed: () {
              setState(() {
                isFilenameEdit = false;
              });            
            },
          ),
          // Кнопка сохранения
          IconButton(
            icon: Icon(Icons.save, size: 28),
            onPressed: () async {
              final Directory directory = await getApplicationDocumentsDirectory();
              print(directory.path);
              final File file = File("${directory.path}/${_filenameController.text}.bf");
              await file.writeAsString(_controller.text);
              setState(() {
                isFilenameEdit = false;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: TextField(
            style: Theme.of(context).textTheme.bodyText1,
            controller: _controller,
            maxLines: 100,
            readOnly: true,
          )),
          Keyboard(controller: _controller)
        ],
      ),
    );
  }
}

class Keyboard extends StatelessWidget {
  const Keyboard({
    Key key,
    @required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      _controller.text += ">";
                    },
                    child: Text(">",
                        style: Theme.of(context).textTheme.bodyText2)),
                FlatButton(
                    onPressed: () {
                      _controller.text += "<";
                    },
                    child: Text("<",
                        style: Theme.of(context).textTheme.bodyText2)),
                FlatButton(
                    onPressed: () {
                      _controller.text += "+";
                    },
                    child: Text("+",
                        style: Theme.of(context).textTheme.bodyText2)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      _controller.text += ".";
                    },
                    child: Text(".",
                        style: Theme.of(context).textTheme.bodyText2)),
                FlatButton(
                    onPressed: () {
                      _controller.text += "-";
                    },
                    child: Text("-",
                        style: Theme.of(context).textTheme.bodyText2)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
              onPressed: (){
                  _controller.text+="[";
              },
              child: Text("[", style: Theme.of(context).textTheme.bodyText2)
            ),
            FlatButton(
              onPressed: (){
                  _controller.text+="]";
              },
              child: Text("]", style: Theme.of(context).textTheme.bodyText2)
            ),
            FlatButton(
              onPressed: (){
                  _controller.text=_controller.text.substring(0, _controller.text.length-1);
              },
              onLongPress: (){
                _controller.text="";
              },
              child: Text("Back", style: Theme.of(context).textTheme.bodyText2)
            ),
              ],
            )
          ],
        )
        );
  }
}
