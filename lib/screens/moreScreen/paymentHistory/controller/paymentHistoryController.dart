import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/model/model_payment_history.dart';

class PaymentHistoryController extends GetxController {
  List<PaymentData> paymentList = [];
  ApiProvider _provider = ApiProvider();
  //MARK: Call API:

  getReviewList() async {
    await _provider.getHomviewerPaymentHistory().then((value) {
      paymentList = value.data ?? [];
      update();
    });
  }
}
