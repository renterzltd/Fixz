// ignore_for_file: prefer_const_constructors, unnecessary_this, unnecessary_string_interpolations, prefer_final_fields, library_private_types_in_public_api

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/taskDetails/bookingTaskDetails/widget/bookingTaskBasicDetails.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewScreen extends StatefulWidget {
  final TENANTREQUEST request;
  const ReviewScreen({super.key, required this.request});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  ApiProvider _apiProvider = ApiProvider();
  double rating = 0.0;
  TextEditingController messageController = TextEditingController();

  _setRatingView() {
    return Container(
      alignment: Alignment.topLeft,
      child: RatingBar.builder(
        initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          debugPrint('rating:$rating');
          this.rating = rating;
        },
      ),
    );
  }

  _addCommentWidget() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray1.lightColorHex()),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(5),
      child: TextFormField(
        controller: messageController,
        decoration: InputDecoration(
          labelText: 'Write comment'.tr,
          border: InputBorder.none,
        ),
        maxLines: 10,
      ),
    );
  }

  _addReview() async {
    final param = {
      'contractor_id': '${this.widget.request.contractorId}',
      'reviews': '${this.rating}',
      'message': '${messageController.text}',
      'quotation_id': '${this.widget.request.quotationId}',
      'job_id': '${this.widget.request.id}'
    };
    await _apiProvider.addRatings(param).then((value) {
      debugPrint('==========response:=>${value.message}');
      if (value.message == 'success') {
        Fluttertoast.showToast(msg: 'Rating Added successfully!!'.tr);
        this.widget.request.isReviewed = true;
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(msg: value.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: AppColors.colorPrimaryDark.lightColorHex()),
        backgroundColor: AppColors.white.lightColorHex(),
        title: setCommonText(
          'Repair Request'.tr,
          color: AppColors.colorPrimaryDark.lightColorHex(),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        elevation: 1.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            setHeight(30),
            setCommonText(
              'Hows the job and Contractor,Please give the review.'.tr,
              fontSize: 15,
              textAlignment: TextAlign.center,
              fontWeight: FontWeight.w400,
            ),
            setHeight(20),
            setCommonText(
              'Add Review'.tr,
              fontSize: 18,
              textAlignment: TextAlign.start,
              fontWeight: FontWeight.w500,
            ),
            setHeight(10),
            _setRatingView(),
            setHeight(15),
            _addCommentWidget(),
            setHeight(50),
            InkWell(
              onTap: () {
                if (this.rating == 0.0) {
                  Fluttertoast.showToast(msg: 'Please add rating first'.tr);
                  return;
                }
                _addReview();
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: AppColors.colorPrimaryDark.lightColorHex(),
                    borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: setCommonText(
                  'Add Review'.tr,
                  color: AppColors.white.lightColorHex(),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
