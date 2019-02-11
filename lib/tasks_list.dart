import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/state/task_store/task_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

typedef void TextInputFieldCallback(String newText);
typedef void OnItemDismissedCallback(String itemId);

final store = TaskStore();

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: store.fetchTasks(),
      builder: (BuildContext context, AsyncSnapshot<void> snap) {
        return new Container(
          child: new Column(
            children: <Widget>[
              Observer(
                builder: (_) => new TaskInputField(
                    store.enteredText, store.onAddClicked, store.onTextChanged),
              ),
              new Expanded(
                child: Observer(
                  builder: (_) => ListView.builder(
                        itemCount: store.tasks.length,
                        itemBuilder: (BuildContext context, int index) =>
                            TaskItem(store.tasks[index].id,
                                store.tasks[index].description,
                                (String itemId) async {
                              store.deleteItem(itemId);
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("Task Deleted")));
                            }),
                      ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
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
              controller: new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: _text,
                      selection:
                          new TextSelection.collapsed(offset: _text.length))),
              onChanged: this._onTextChanged,
            ),
          ),
        )
      ],
    );
  }
}
