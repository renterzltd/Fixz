// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fixz/common_view/common_shimmer_view.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/screens/disputeRequest/dispute_request.dart';
import 'package:fixz/screens/reviewScreen/reviewScreen.dart';
import 'package:fixz/screens/taskListScreen/widgets/bookinListWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/bookingTaskBasicDetails.dart';
import 'widget/bookingTaskTypeListWidget.dart';

class BookingTaskDetails extends StatefulWidget {
  final String taskId;
  // final String status;
  // final String reviwed;
  const BookingTaskDetails({
    Key? key,
    required this.taskId,
    // required this.status,
    // required this.reviwed
  }) : super(key: key);

  @override
  State<BookingTaskDetails> createState() => _BookingTaskDetailsState();
}

class _BookingTaskDetailsState extends State<BookingTaskDetails>
    with AppbarMixin, ButtonMixin {
  final controller = Get.put(TaskDetailController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // log('Widget status:${widget.status}');
    // this is for BG navigation.
    controller.getUserName();
    SharedManager.shared.isNavigateBG = false;

    Future.delayed(Duration(milliseconds: 300), () {
      controller.fillData();
      controller.setValue('0');
      controller.getTaskDetails(widget.taskId.toString());
    });
  }

  //MARK: API Call for cancel task

  // _cancelTask() async {
  //   ApiProvider _apiProvider = ApiProvider();
  //   final param = {'job_id': widget.taskId};
  //   await _apiProvider.deleteTaks(param).then((value) {
  //     if (value.message == 'success') {
  //       Navigator.of(context).pop('yes');
  //     }
  //   });
  // }

  // _setImageWidget(List<TaskImages> taskImage) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       setCommonText('Task Images'),
  //       setHeight(5),
  //       Container(
  //         height: 100,
  //         child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: taskImage.length,
  //             itemBuilder: (context, index) {
  //               final item = taskImage[index];
  //               return Padding(
  //                 padding: const EdgeInsets.all(5.0),
  //                 child: InkWell(
  //                   onTap: () {
  //                     Navigator.of(context).push(MaterialPageRoute(
  //                         builder: (context) => ZoomableImagePage(
  //                               images: [item.documentName!],
  //                             )));
  //                   },
  //                   child: setNetworkImage(item.documentName!, 80, 80),
  //                 ),
  //               );
  //             }),
  //       ),
  //       setHeight(10),
  //     ],
  //   );
  // }
  _launchURL(String phone) async {
    // final url = 'tel:$phone';
    try {
      // launch("tel://214324234");
      Uri url = Uri(scheme: "tel", path: phone);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        debugPrint("Can't open dial pad.");
      }
    } catch (err) {
      throw 'Could not launch $err';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<TaskDetailController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDetailController>(
      builder: (con) {
        return Scaffold(
          appBar: setAppbar('Task Details'.tr,
              bgColor: AppColors.white.lightColorHex(),
              elivation: 1.0,
              action: [
                if (controller.taskDetails?.status == 0)
                  Align(
                    child: createButton(
                      height: 30,
                      width: 30,
                      borderRadius: BorderRadius.circular(15),
                      widget: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 20,
                      ),
                      onBtnClick: () {
                        _launchURL(controller
                                .taskDetails?.acceptedQuotation?.mobileNumber ??
                            '');
                      },
                    ),
                  ),
                setWidth(5),
              ],
              onBackClick: () {}),
          body: con.isLoading
              ? CommonShimmerView()
              : Column(
                  children: [
                    BookingTaskTypeListWidget(),
                    setHeight(10),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: BookingTaskBasicDetails(),
                      ).addPulltoRefresh((p0) => {
                            con.getTaskDetails(widget.taskId),
                          }),
                    ),
                    if (con.taskDetails != null)
                      Container(
                        height: 60,
                        color: AppColors.colorPrimaryDark.lightColorHex(),
                        child: Row(
                          children: [
                            Expanded(
                              child: createButton(
                                  fontSize: 18,
                                  hideGradient: true,
                                  text: (con.taskDetails?.isReviewed == '0')
                                      ? 'Submit Review'.tr
                                      : 'Job Completed'.tr,
                                  txtColor: Colors.white,
                                  widget: (con.taskDetails?.status == 1)
                                      ? null
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.place,
                                                color: Colors.white, size: 20),
                                            setWidth(3),
                                            setCommonText('Track Contractor'.tr,
                                                color: AppColors.white
                                                    .lightColorHex())
                                          ],
                                        ),
                                  onBtnClick: () async {
                                    if (con.taskDetails?.status == 0) {
                                      //API call
                                      // Get first location
                                      // If location get we will move to map screen else
                                      // Please wait untill contractor notify you
                                      // NavigationService().setNavigator(ContractorTrackingPage());
                                      //Check in task details is notify or not.
                                      if (con.taskDetails?.isNotify == '1') {
                                        //API CALL FIRST
                                        con.trackContracor();
                                      } else {
                                        AlertClass.shared.setSnackbar(
                                            'You will be able to track the service provider a few hours before the job'
                                                .tr);
                                      }
                                    } else {
                                      if (con.taskDetails?.isReviewed == '0') {
                                        TENANTREQUEST request = TENANTREQUEST(
                                            con.taskDetails?.id ?? 0,
                                            con.taskDetails?.details,
                                            con.taskDetails?.description ?? '',
                                            con.taskDetails?.time ?? '',
                                            con.taskDetails?.acceptedQuotation
                                                    ?.name ??
                                                '',
                                            con.taskDetails?.status.toString(),
                                            '',
                                            con.taskDetails?.review ?? '',
                                            false,
                                            con.taskDetails?.acceptedQuotation
                                                ?.contractorId,
                                            con.taskDetails?.acceptedQuotation
                                                ?.quotationId);

                                        await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewScreen(
                                                        request: request)))
                                            .then((value) {
                                          con.getTaskDetails(
                                              '${con.taskDetails?.id}');
                                        });
                                      }
                                    }
                                  }),
                            ),
                            if (con.taskDetails?.isReviewed == '0' &&
                                (con.taskDetails?.status == 1)) ...[
                              Container(
                                width: 1,
                                color: AppColors.white.lightColorHex(),
                              ),
                              Expanded(
                                child: createButton(
                                    text: con.taskDetails?.isReported == '0'
                                        ? 'Dispute Request'
                                        : 'Request Submitted',
                                    txtColor: AppColors.white.lightColorHex(),
                                    hideGradient: true,
                                    fontSize: 18,
                                    onBtnClick: () async {
                                      con.isLoading = true;
                                      if (con.taskDetails?.isReported == '0') {
                                        final res =
                                            await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DisputeRequest(
                                                    taskDetails:
                                                        con.taskDetails),
                                          ),
                                        );
                                        con.getTaskDetails(
                                            widget.taskId.toString());
                                      }
                                    }),
                              ),
                            ],
                          ],
                        ),
                      )
                  ],
                ),
        );
      },
    );
  }
}
