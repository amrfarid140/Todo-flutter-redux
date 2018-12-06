class Todo {
  String id;
  String title;
  String body;
  int timestamp;

  Todo(this.id, this.title, this.body, this.timestamp);

  Todo.empty(String id) {
    this.id = id;
    this.title = "";
    this.body = "";
  }
}