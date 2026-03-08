// ignore_for_file: prefer_final_fields

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/model/model_review_list.dart';

class ReviewController extends GetxController {
  ApiProvider _provider = ApiProvider();
  List<ReviewData> reviewData = [];
  //MARK: Call API:

  getReviewList() async {
    await _provider.getHomeviewerReviewList().then((value) {
      reviewData = value.reviewList ?? [];
      update();
    });
  }
}
