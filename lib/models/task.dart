class Task {
    String id;
    String description;
    int timestamp;

    Task(this.id, this.description, this.timestamp);
    Task.fromMap(Map input) { 
      this.id = input["id"];
      this.description = input["description"];
      this.timestamp = input["timestamp"];
    } 
  
    Map<String,dynamic> toMap() {
      Map<String,dynamic> output = Map();
      output.addEntries([
        MapEntry("id", this.id),
        MapEntry("description", this.description),
        MapEntry("timestamp", this.timestamp)
      ]);
      return output;
    }
}