import 'todo_model.dart';

class TodoState {
  final List<TodoModel> tasks;  //state دي مهمتها انها بتشيل جواها ليست المهام وتبعتها لل ui 
 TodoState({required this.tasks});
}