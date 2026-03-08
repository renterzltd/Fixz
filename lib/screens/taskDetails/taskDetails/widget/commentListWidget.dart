// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';

class CommentListWidget extends StatefulWidget {
  final int index;
  const CommentListWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<CommentListWidget> createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  final controller = Get.find<TaskDetailController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDetailController>(
      builder: (con) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: 0,
            // itemCount: 1,
            itemBuilder: (context, index) {
              // final item = con.offerList[widget.index].commentList[index];
              return SizedBox(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(22.5),
                      // ignore: prefer_const_constructors
                      child: Image(
                        image: AssetImage(
                          'assets/images/ic_circle_user.png',
                        ),
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    setWidth(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColors.colorPrimary
                                    .lightColorHex()
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  setCommonText(con.userName,
                                      color: Colors.grey, fontSize: 12),
                                  setHeight(5),
                                  setCommonText(
                                    'item.title',
                                    color: Colors.black87,
                                    fontSize: 12,
                                    noOfLine: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          setHeight(5),
                          Align(
                              child: setCommonText(
                                '1 min ago'.tr,
                                color: Colors.black87,
                                fontSize: 12,
                                noOfLine: 4,
                              ),
                              alignment: Alignment.centerRight),
                          setHeight(3)
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}
