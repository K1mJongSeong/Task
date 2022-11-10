import 'package:get/get.dart';
import 'package:untitled/db/db_helper.dart';
import 'package:untitled/models/task.dart';

class TaskController extends GetxController{

  @override
  void onRead(){
    super.onReady();
  }

  Future<int> addTask({Task? task})async{
    return await DBHelper.insert(task);
  }
}