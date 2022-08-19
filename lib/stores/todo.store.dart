import 'package:mobx/mobx.dart';
import 'package:gc_qrcode/models/todo.model.dart';
part 'todo.store.g.dart';

// ignore: library_private_types_in_public_api
class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  @observable
  var todos = ObservableList<Todo>();

  @action
  void add(Todo todo) {
    todos.add(todo);
  }
}
