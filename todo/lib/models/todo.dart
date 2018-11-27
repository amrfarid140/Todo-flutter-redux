class Todo {
  String id;
  String title;
  String body;

  Todo(this.id, this.title, this.body);

  Todo.empty(String id) {
    this.id = id;
    this.title = "";
    this.body = "";
  }
}