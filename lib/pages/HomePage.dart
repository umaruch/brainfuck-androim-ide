import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'CodePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List _projects = [];

  void _loadProjects() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    setState(() {
      _projects = directory.listSync();
      _projects=_projects.sublist(2, _projects.length);
    });
    print(_projects.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("b{G}r{AY}nfuckIDE", style: Theme.of(context).textTheme.headline1),
      ),

      body: _projects.length==0?_welCUMeScreen():_projectsList(),
    

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 32),
        onPressed: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context)=>CodePage(filename: "Новый проект", code: ""))).then((value) => _loadProjects());
          _loadProjects();
        },
      ),
    );
  }

  Container _welCUMeScreen() => Container(
    constraints: BoxConstraints(maxWidth: 800),

    alignment: Alignment.center,

    child: Text("У вас пока ничего нет(", style: Theme.of(context).textTheme.headline2),
  );

  Container _projectsList() => Container(
    constraints: BoxConstraints(maxWidth: 800),

    child: ListView.builder(
      itemCount: _projects.length,
      itemBuilder: (context, i) =>Dismissible(
          key: UniqueKey(),

          background: Container(
            padding: EdgeInsets.only(right: 20),
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, size: 32, color: Colors.white)
          ),

          direction: DismissDirection.endToStart,

          confirmDismiss: (direction){
             _projects[i].deleteSync(recursive: true);
             setState(() {
               _projects.remove(_projects[i]);
             });
          },

          child: ListTile(
          leading: Icon(Icons.code),
          title: Text(_projects[i].path.split("/").last),

          onTap: (){
            File file = File(_projects[i].path);
            String code = file.readAsStringSync();
            Navigator.push(context, CupertinoPageRoute(builder: (context)=>CodePage(filename: _projects[i].path.split("/").last.split(".")[0], code: code))).then((value) => _loadProjects());
            _loadProjects();
          },
        ),
      )
    ),
  );
}