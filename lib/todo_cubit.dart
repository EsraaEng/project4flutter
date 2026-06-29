import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_model.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit (): super (TodoState(tasks: []));  //init state بتكون ليست فاضيه عشان الui ميستناش داتا 

  void addTask(String taskTitle){
    if (taskTitle.trim().isEmpty)return;   //لو اليوزر دخل اسم التاسك مسافات بس مثلا يعني الاسم فاضي   كلمة return بتقفل الداله ومش بتعمل حاجه عشان ui شكله ميبوظش
    final updateTask=List<TodoModel> .from(state.tasks)..add(TodoModel(title: taskTitle));  //بناخد نسخه من الليست القديمه وبنضيف عليها تاسك جديد 
    emit(TodoState(tasks: updateTask));  // عشان ui يحدث نفسه علي طول من غير refresh
  }

  void deleteTask(int index){
    final updateTask=List<TodoModel> .from(state.tasks); //بناخد نسخه من الليست الموجوده 
    updateTask.removeAt(index);  //بنحذف التاسك عن طريق index
    emit(TodoState(tasks: updateTask));  //بنبعت الليست الجديده بهد الحذف لل ui
  }

 void toggleTaskstate(int index){
  final updateTask=List<TodoModel> .from(state.tasks);
  updateTask[index].isCompleted=!updateTask[index].isCompleted;   // ! بتعكس الحاله 
  emit(TodoState(tasks: updateTask)); 
 }

}