import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/models/task.dart';
import 'package:todo/provider/task_provider.dart';
import 'package:uuid/uuid.dart';

typedef void TextInputFieldCallback(String newText);
typedef void OnItemDismissedCallback(String itemId);

class TaskListState extends State<TaskList> {
  final List<Task> _tasks = new List();
  final TaskProvider _taskProvider = new TaskProvider();
  String _enteredText = "";

  @override
  void initState() {
    super.initState();
    _taskProvider
        .open()
        .then((dbOpen) => _taskProvider.getAllTasks())
        .then((exisitngItems) => setState(() {
              _tasks.clear();
              _tasks.addAll(exisitngItems);
            }));
  }

  void _onAddClicked() {
    if (_enteredText.isNotEmpty) {
      Task createdTask = Task(
          Uuid().v4(), _enteredText, new DateTime.now().millisecondsSinceEpoch);
      _taskProvider.insertTask(createdTask).then((addedTask) => setState(() {
            _tasks.add(addedTask);
            _enteredText = "";
          }));
    } else {}
  }

  void _onEnteredTextChanged(String newText) {
    _enteredText = newText;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new TaskInputField(
              _enteredText, _onAddClicked, _onEnteredTextChanged),
          new Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (BuildContext context, int index) =>
                  TaskItem(_tasks[index].id, _tasks[index].description,
                      (String itemId) async {
                    await _taskProvider.deleteTask(itemId);
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("Task Deleted")));
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TaskListState();
}

class TaskItem extends StatelessWidget {
  final String _id;
  final String _text;
  final OnItemDismissedCallback _dismissedCallback;
  TaskItem(this._id, this._text, this._dismissedCallback);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this._id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        this._dismissedCallback(this._id);
      },
      background: Container(
        padding: EdgeInsets.only(left: 0.0, right: 16.0, top: 0.0, bottom: 0.0),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        color: Colors.red,
      ),
      child: InkWell(
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
            margin: EdgeInsets.only(bottom: 8.0, top: 8.0),
            padding:
                EdgeInsets.only(left: 8.0, top: 0.0, bottom: 8.0, right: 0.0),
            child: TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter new task',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _onAddClicked,
                  )),
              controller: new TextEditingController(text: _text),
              onChanged: this._onTextChanged,
            ),
          ),
        )
      ],
    );
  }
}
