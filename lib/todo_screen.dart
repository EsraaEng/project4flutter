import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'todo_cubit.dart';
import 'todo_state.dart';


class TodoScreen extends StatelessWidget  {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController =TextEditingController();

    return Scaffold(
     backgroundColor: const Color.fromARGB(255, 238, 234, 217),
      appBar: AppBar(
        title: const Text("TOday's Tasks" , style: TextStyle(color: Color.fromARGB(255, 198, 127, 20) , fontWeight: FontWeight.bold),),
       backgroundColor: const Color.fromARGB(255, 238, 234, 217),
       centerTitle: true,
      ),
        

      body: 
      BlocBuilder<TodoCubit, TodoState>(  
        //بيعيد رسم ui تلقائيا بعد التعديل
        builder: (context , state){
           // الجزء اللي بيعمل اختبار للليست لو فاضيه هيكتب مفيش مهام
          if (state.tasks.isEmpty){
            return const Center(
              child: Text("Set your goals🚀", 
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 116, 119, 118),fontWeight: FontWeight.w500,  ),),
            );
          }
            // الجزء ده لو الليست مش فاضيه بيحدد عدد الصفوف بناءا علي التاسكات الموجوده
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context,index){
              final task =state.tasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12 , vertical: 6),
                elevation: 2,
                child: ListTile(
                  // بوكس صغير بيوضح حالة التاسك هل تم ولا لا
                  leading: Checkbox(value: task.isCompleted, onChanged: (value){
                    context.read<TodoCubit>().toggleTaskstate(index);
                  },),
                  
                    title: Text(task.title ,
                    style: TextStyle(
                      decoration: task.isCompleted ? TextDecoration.lineThrough :TextDecoration.none,
                      color: task.isCompleted ? Colors.grey: const Color.fromARGB(255, 18, 34, 31), // لو التاسك مكتمل هيعمل خط فوق الكلمه ولونها يبقي رمادي ولو لسه مكملتش هيفضل بلونه العادي

                    ),
                    ),

                      trailing :IconButton(
                         icon: const Icon(Icons.delete , color: Color.fromARGB(255, 177, 66, 58)),
                        onPressed: (){
                        context.read<TodoCubit>().deleteTask(index);
                      }, 
      
                      ),
                ),
              );
            },
            );
        },
        ),

        // الجزء ده لكتابة مهمه جديده 
    floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 24, 35, 27),
        onPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text('Add a new task', textAlign: TextAlign.right),
              content: TextField(
                controller: textController,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Enter your task here... '),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    textController.clear();
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Delet', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    context.read<TodoCubit>().addTask(textController.text);
                    textController.clear();
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Add', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
 