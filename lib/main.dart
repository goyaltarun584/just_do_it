import 'package:flutter/material.dart';

void main(){
  runApp(new Todoapp());
}

class Todoapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Just do it!",
      home: new justdoit(),
    );
  }
}

class justdoit extends StatefulWidget {
  @override
  _justdoitState createState() => _justdoitState();
}

class _justdoitState extends State<justdoit> {

  List<String> _todoitems = [];



  Widget _buildtodolist(){
    return new ListView.builder(
      itemBuilder: (context,index){
      if(index < _todoitems.length){
        return _buildtodoitem(_todoitems[index],index);
      }
    },);
  }


  Widget _buildtodoitem(String todotext,int index){

    return new ListTile(
      title: new Text(todotext),
      onTap: ()=> _promptremovetodoitem(index),
    );

  }

  void _addtodoitem(String task){
    if(task.length>0){
      setState(() =>_todoitems.add(task));
    }
  }

  void _removetodoitem(int index){
    setState(()=> _todoitems.removeAt(index));
  }

  void _promptremovetodoitem(int index){
    showDialog(
        context: context,
        builder: (BuildContext context){
         return new AlertDialog(
        title: new Text("Mark '$_todoitems[index]' as done?"),
        actions: <Widget>[
          new FlatButton(
         child: new Text('Cancel'),
          onPressed: ()=>Navigator.of(context).pop()
          ),
          new FlatButton(
            child: new Text("Mark as Done"),
              onPressed: (){ _removetodoitem(index);
              Navigator.of(context).pop(); }
              )
          
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Just do it"),
      ),
      body: _buildtodolist(),
      floatingActionButton: new FloatingActionButton(onPressed: _pushaddtodoscreen,
        tooltip: "Add task",
        child: new Icon (Icons.add),
      ),
    );
  }
  void _pushaddtodoscreen(){
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context){
        return new Scaffold(
          appBar: new AppBar(
            title: Text("Add a new task"),
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val){
              _addtodoitem(val);
              Navigator.pop(context);
            },
            decoration: new InputDecoration(
              hintText: "What is in your mind?",
              contentPadding: const EdgeInsets.all(16.0)

            ),
          )
        );
      })
    );
  }
}

