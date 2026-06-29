class TodoModel{
  String title;        //اسم التاسك
  bool isCompleted;     // هل التاسك خلص ولا لسه

TodoModel({
required this.title,     // يشترط يكون في اسم للتاسك 
this.isCompleted=false,      //الحاله الابتدائيه للتاسك انه مش مكتمل 
});  
}