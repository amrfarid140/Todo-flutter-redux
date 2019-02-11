// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$TaskStore on TaskStoreBase, Store {
  final _$tasksAtom = Atom(name: 'TaskStoreBase.tasks');

  @override
  List<Task> get tasks {
    _$tasksAtom.reportObserved();
    return super.tasks;
  }

  @override
  set tasks(List<Task> value) {
    mainContext.checkIfStateModificationsAreAllowed(_$tasksAtom);
    super.tasks = value;
    _$tasksAtom.reportChanged();
  }

  final _$enteredTextAtom = Atom(name: 'TaskStoreBase.enteredText');

  @override
  String get enteredText {
    _$enteredTextAtom.reportObserved();
    return super.enteredText;
  }

  @override
  set enteredText(String value) {
    mainContext.checkIfStateModificationsAreAllowed(_$enteredTextAtom);
    super.enteredText = value;
    _$enteredTextAtom.reportChanged();
  }

  final _$fetchTasksAsyncAction = AsyncAction('fetchTasks');

  @override
  Future<void> fetchTasks() {
    return _$fetchTasksAsyncAction.run(() => super.fetchTasks());
  }

  final _$onAddClickedAsyncAction = AsyncAction('onAddClicked');

  @override
  Future<void> onAddClicked() {
    return _$onAddClickedAsyncAction.run(() => super.onAddClicked());
  }

  final _$deleteItemAsyncAction = AsyncAction('deleteItem');

  @override
  Future<void> deleteItem(String itemId) {
    return _$deleteItemAsyncAction.run(() => super.deleteItem(itemId));
  }

  final _$TaskStoreBaseActionController =
      ActionController(name: 'TaskStoreBase');

  @override
  void onTextChanged(String text) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction();
    try {
      return super.onTextChanged(text);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
