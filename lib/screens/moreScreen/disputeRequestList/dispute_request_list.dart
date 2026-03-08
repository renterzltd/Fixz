import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/moreScreen/controller/more_controller.dart';
import 'package:fixz/screens/moreScreen/disputeRequestList/dispute_deails.dart';
import 'package:fixz/screens/taskListScreen/widgets/bookinListWidgets.dart';

class DisputeRequestList extends StatelessWidget {
  const DisputeRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoreController());
    controller.getDisputeRequestList();
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: AppColors.colorPrimaryDark.lightColorHex()),
        backgroundColor: AppColors.white.lightColorHex(),
        title: setCommonText(
          'Dispute Requests'.tr,
          color: AppColors.colorPrimaryDark.lightColorHex(),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        elevation: 1.0,
      ),
      body: GetBuilder<MoreController>(
        builder: (con) {
          return ListView.builder(
            itemCount: con.requestList.length,
            itemBuilder: ((context, index) {
              final item = con.requestList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: InkWell(
                  onTap: () async {
                    con.updateData(index);
                    final status =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DisputeDetailsPage(item: item),
                    ));
                    if (status == 'yes') {
                      con.getDisputeRequestList();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        setCommonText(
                          '${item.jobTitle}',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        setCommonText(
                          '${item.jobDescription}',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          noOfLine: 2,
                          color: Colors.grey.shade500,
                        ),
                        setHeight(5),
                        Row(
                          children: [
                            setCommonText(
                              'Contractor Name:',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              noOfLine: 2,
                              color: Colors.grey.shade700,
                            ),
                            Expanded(
                              child: setCommonText(
                                '${item.contractorName}',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                noOfLine: 2,
                                color: Colors.grey.shade700,
                              ),
                            )
                          ],
                        ),
                        setHeight(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: setCommonText(
                                'More Details',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                noOfLine: 2,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            setWidth(4),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Colors.grey.shade800,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ).addPulltoRefresh((p0) {
            controller.getDisputeRequestList();
          });
        },
      ),
    );
  }
}
