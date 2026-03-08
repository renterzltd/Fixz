import 'package:fixz/hdHelper/exportFile.dart';

class TaskAlertController extends GetxController {
  List<AlertTask> alertTaskList = [];
  bool isRemote = true;

  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskLocationController = TextEditingController();
  TextEditingController taskDistanceController = TextEditingController();

  addTask() {
    if (taskTitleController.text.isEmpty) {
      AlertClass.shared.setSnackbar('Please enter task');
      return;
    }
    alertTaskList.add(AlertTask(
        distance: '',
        isRemote: '',
        location: '',
        title: taskTitleController.text));
    taskTitleController.text = '';
    NavigationService().setPopNavigator();
    update();
  }

  removeTask(int index) {
    alertTaskList.removeAt(index);
    update();
  }
}

class AlertTask {
  String title;
  String isRemote;
  String location;
  String distance;

  AlertTask(
      {this.distance = "",
      this.isRemote = "",
      this.location = "",
      this.title = ""});
}
