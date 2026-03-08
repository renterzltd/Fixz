import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/model/model_dispute_request_list.dart';

class MoreController extends GetxController {
  //API CALL

  List<DisputeRequestData> requestList = [];

  TextEditingController reasonController = TextEditingController();

  void getDisputeRequestList() {
    ApiProvider().getDisputeRequest().then((value) {
      if (value.message == 'success') {
        requestList = value.disputeList ?? [];
        update();
      }
    });
  }

  void updateData(index) {
    reasonController.text = requestList[index].description ?? '';
    update();
  }

  void updateDisputeRequest({
    required String reportId,
    bool isCancel = false,
    required BuildContext context,
  }) {
    final param = {
      'status': isCancel ? '9' : '1',
      'report_id': reportId,
    };
    ApiProvider().updateDisputeRequest(param).then((value) {
      if (value.message == 'success') {
        //
        if (isCancel) {
          AlertClass.shared.setSnackbar('Request cancelled successfully!!');
          Navigator.of(context).pop('yes');
        } else {
          AlertClass.shared.setSnackbar('Request resolved successfully!!');
          Navigator.of(context).pop('yes');
        }
      }
    });
  }
}
// status
// 0=> received/pending
// 1==> Resolved
// 9=>cancelled
// 2=>Inprocess
