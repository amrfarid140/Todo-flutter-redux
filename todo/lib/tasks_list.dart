import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/models/task.dart';
import 'package:uuid/uuid.dart';

typedef void TextInputFieldCallback(String newText);

class TaskListState extends State<TaskList> {
  final List<Task> _tasks = new List();
  String _enteredText = "";
  void _onAddClicked() {
    setState(() {
      if (_enteredText.isNotEmpty) {
        _tasks.add(Task(Uuid().v4(), _enteredText));
        _enteredText = "";
      }
    });
  }

  void _onEnteredTextChanged(String newText) {
    _enteredText = newText;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (BuildContext context, int index) =>
                  TaskItem(_tasks[index].description),
            ),
          ),
          new TaskInputField(
              _enteredText, _onAddClicked, _onEnteredTextChanged),
        ],
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TaskListState();
}
// class TaskList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       child: new Column(
//         children: <Widget>[
//           new Expanded(
//             child: ListView.builder(
//               itemCount: 100,
//               itemBuilder: (BuildContext context, int index) => TaskItem("Task # $index"),
//             ),
//           ),
//           new TaskInputField(),
//         ],
//       ),
//     );
//   }
// }

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
  final String _text;
  final VoidCallback _onAddClicked;
  final TextInputFieldCallback _onTextChanged;

  TaskInputField(this._text, this._onAddClicked, this._onTextChanged);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: Container(
            padding:
                EdgeInsets.only(left: 8.0, top: 0.0, bottom: 0.0, right: 0.0),
            child: TextField(
              controller: new TextEditingController(text: _text),
              onChanged: this._onTextChanged,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _onAddClicked,
        )
      ],
    );
  }
}
