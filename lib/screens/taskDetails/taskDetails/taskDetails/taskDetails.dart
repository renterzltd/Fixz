// ignore_for_file: prefer_const_constructors, prefer_is_empty, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/screens/taskDetails/taskDetails/widget/offerListWidget.dart';
import 'package:fixz/screens/taskDetails/taskDetails/widget/taskBasicDetails.dart';
import 'package:fixz/screens/taskDetails/taskDetails/widget/taskTypeListWidget.dart';

class TaskDetails extends StatefulWidget {
  final String taskId;
  const TaskDetails({Key? key, required this.taskId}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> with AppbarMixin {
  final controller = Get.put(TaskDetailController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // this is for BG navigation.
    controller.getUserName();
    SharedManager.shared.isNavigateBG = false;
    Future.delayed(Duration(milliseconds: 200), () {
      controller.getTaskDetails(widget.taskId.toString());
    });
  }

  //MARK: API Call for cancel task

  _cancelTask() async {
    ApiProvider _apiProvider = ApiProvider();
    final param = {'job_id': widget.taskId};
    await _apiProvider.deleteTaks(param).then((value) {
      if (value.message == 'success') {
        Navigator.of(context).pop('yes');
      }
    });
  }

  _setImageWidget(List<TaskImages> taskImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setCommonText('Task Images'.tr),
        setHeight(5),
        Container(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: taskImage.length,
              itemBuilder: (context, index) {
                final item = taskImage[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ZoomableImagePage(
                                images: [item.documentName!],
                              )));
                    },
                    child: setNetworkImage(item.documentName!, 80, 80),
                  ),
                );
              }),
        ),
        setHeight(10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Task Details'.tr,
          bgColor: AppColors.white.lightColorHex(),
          elivation: 1.0,
          action: [
            InkWell(
              onTap: () {
                AlertClass.shared
                    .shoAlertWindow("Are you sure you want to cancel task?".tr,
                        buttonPress: (status) async {
                  if (status) {
                    if (status) {
                      _cancelTask();
                    }
                  }
                });
              },
              child: Padding(
                padding: EdgeInsets.only(right: 15, top: 20),
                child: setCommonText(
                  'Cancel Task'.tr,
                  fontSize: 14,
                  color: AppColors.black.lightColorHex(),
                  fontWeight: FontWeight.w500,
                  noOfLine: 1,
                ),
              ),
            )
          ],
          onBackClick: () {}),
      body: GetBuilder<TaskDetailController>(
        builder: (con) {
          return Column(
            children: [
              TaskTypeListWidget(
                status: '${con.taskDetails?.status}',
              ),
              setHeight(10),
              Expanded(
                child: con.taskDetails == null
                    ? SizedBox.shrink()
                    : ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          TaskBasicDetails(),
                          if (con.taskDetails!.images.isNotEmpty)
                            _setImageWidget(con.taskDetails!.images),
                          OfferListWidget(),
                        ],
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}
