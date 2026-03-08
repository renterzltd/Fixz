// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';

class TaskBasicDetails extends StatefulWidget {
  const TaskBasicDetails({Key? key}) : super(key: key);

  @override
  State<TaskBasicDetails> createState() => _TaskBasicDetailsState();
}

class _TaskBasicDetailsState extends State<TaskBasicDetails> {
  final controller = Get.find<TaskDetailController>();

  _setUserInfoWidget({required String userName, required String profileImg}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ignore: prefer_const_constructors
        (profileImg != '')
            ? ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: setNetworkImage(
                  profileImg,
                  40,
                  40,
                ),
              )
            : Image(
                image: AssetImage(
                  'assets/images/ic_circle_user.png',
                ),
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
        setWidth(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              setCommonText(
                'POSTED BY'.tr,
                fontSize: 14,
                color: AppColors.black.lightColorHex(),
                fontWeight: FontWeight.w500,
                noOfLine: 1,
              ),
              setCommonText(
                userName,
                fontSize: 12,
                color: AppColors.colorPrimaryDark.lightColorHex(),
                fontWeight: FontWeight.w500,
                noOfLine: 1,
              ),
              setCommonText(
                'Now'.tr,
                fontSize: 12,
                color: AppColors.black.lightColorHex(),
                fontWeight: FontWeight.w500,
                noOfLine: 1,
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 35,
              ),
            ],
          ),
        )
      ],
    );
  }

  _setUserLocationWidget(
      String title, String value, String subValue, IconData icon,
      {Function? onClick}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        setWidth(10),
        Icon(
          icon,
          color: Colors.grey,
        ),
        setWidth(20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              setCommonText(
                title,
                fontSize: 14,
                color: AppColors.gray.lightColorHex(),
                fontWeight: FontWeight.w500,
                noOfLine: 1,
              ),
              setHeight(3),
              setCommonText(
                value,
                fontSize: 12,
                color: AppColors.colorPrimaryDark.lightColorHex(),
                fontWeight: FontWeight.w500,
                noOfLine: 2,
              ),
              setHeight(3),
              InkWell(
                onTap: () {},
                child: setCommonText(
                  subValue,
                  fontSize: 12,
                  color: AppColors.black.lightColorHex(),
                  fontWeight: FontWeight.w500,
                  noOfLine: 2,
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 35,
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDetailController>(
      builder: (con) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setCommonText(
              '${con.taskDetails?.details}',
              fontSize: 15,
              color: AppColors.black.lightColorHex(),
              fontWeight: FontWeight.w500,
              noOfLine: 2,
            ),
            setHeight(15),
            _setUserInfoWidget(
                profileImg: con.userImage, userName: con.userName),
            _setUserLocationWidget(
                'LOCATION'.tr, con.taskDetails?.location ?? '', '', Icons.place,
                // 'LOCATION', con.taskDetails.location, 'View map', Icons.place,
                onClick: () {}),
            _setUserLocationWidget(
                'TO BE DONE ON'.tr,
                '${con.taskDetails?.repairingDate}',
                getStringwithNewLine('${con.taskDetails?.time}'),
                Icons.calendar_today,
                onClick: () {}),
            setHeight(15),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: AppColors.colorPrimary.lightColorHex(),
                  )),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    color: AppColors.colorPrimary.lightColorHex(),
                    alignment: Alignment.center,
                    child: setCommonText(
                      'Awaiting Quotations',
                      fontSize: 12,
                      color: AppColors.white.lightColorHex(),
                      fontWeight: FontWeight.w500,
                      noOfLine: 1,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: setCommonText(
                        'Awaiting offers'.tr,
                        fontSize: 15,
                        color: AppColors.black.lightColorHex(),
                        fontWeight: FontWeight.w500,
                        noOfLine: 1,
                        textAlignment: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            setHeight(10),
            setCommonText(
              'Details'.tr,
              fontSize: 16,
              color: AppColors.black.lightColorHex(),
              fontWeight: FontWeight.w500,
              noOfLine: 1,
            ),
            setHeight(10),
            setCommonText(
              '${con.taskDetails?.description}',
              fontSize: 14,
              color: AppColors.gray.lightColorHex(),
              fontWeight: FontWeight.w400,
              noOfLine: 3,
            ),
            setHeight(10),
            Divider(color: Colors.grey),
            setHeight(10),
          ],
        );
      },
    );
  }
}

//assets/images/ic_circle_user.png
