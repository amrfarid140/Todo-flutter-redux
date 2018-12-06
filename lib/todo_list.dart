import 'package:flutter/widgets.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new Center(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          TodoItem(),
        ],
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        Text("1234")
      ],
    );
  }

}