import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) => TaskItem("Task # $index"),
            ),
          ),
          new TaskInputField(),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String _text;
  TaskItem(this._text);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(24.0),
        child: new Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    left: 0.0, right: 16.0, top: 0.0, bottom: 0.0),
                child: Icon(Icons.check)),
            Text(_text)
          ],
        ),
      ),
    );
  }
}

class TaskInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: 8.0,
              top: 0.0,
              bottom: 0.0,
              right: 0.0 
            ),
            child: TextField(),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        )
      ],
    );
  }
}
