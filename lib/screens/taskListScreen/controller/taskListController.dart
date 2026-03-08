// ignore_for_file: prefer_final_fields

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/model/model_task_list.dart';

class TaskListController extends GetxController {
  //Variables
  List<TaskListData> taskList = [];
  ApiProvider _apiProvider = ApiProvider();
  bool loading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

//USER INTERECTIONS

//API CALL

  getTaskList(String id) async {
    updateLoading();
    await _apiProvider.getHomviewerTaskList(id).then((value) {
      taskList = value.taskList;
      loading = false;
      update();
    });
  }

  updateLoading() {
    loading = true;
    update();
  }
}
