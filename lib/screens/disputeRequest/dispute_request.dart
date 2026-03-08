import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/screens/disputeRequest/controller/dispute_request_controller.dart';

import 'bottomsheet_with_doc_options.dart';

class DisputeRequest extends StatefulWidget {
  final TaskDetailData? taskDetails;
  const DisputeRequest({super.key, this.taskDetails});

  @override
  State<DisputeRequest> createState() => _DisputeRequestState();
}

class _DisputeRequestState extends State<DisputeRequest>
    with AppbarMixin, ButtonMixin {
  final controller = Get.put(DisputeConctroller());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<DisputeConctroller>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: AppColors.colorPrimaryDark.lightColorHex()),
        backgroundColor: AppColors.white.lightColorHex(),
        title: setCommonText(
          'Dispute Request'.tr,
          color: AppColors.colorPrimaryDark.lightColorHex(),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        elevation: 1.0,
      ),
      body: GetBuilder<DisputeConctroller>(
        builder: (con) {
          return Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _setCommonWidgetTitleWithValue(
                            title: 'Job Title:',
                            value: '${widget.taskDetails?.details}'),
                        setHeight(10),
                        _setCommonWidgetTitleWithValue(
                          title: 'Description:',
                          value: '${widget.taskDetails?.description}',
                        ),
                        setHeight(10),
                        setCommonText(
                          'Write Your Reason:',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        setHeight(5),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.gray1.lightColorHex()),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextFormField(
                            controller: con.description,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              // labelText: 'Write comment'.tr,
                              border: InputBorder.none,
                              hintText: 'Write your reason here...',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            maxLines: null,
                          ),
                        ),
                        setHeight(10),
                        setCommonText(
                          'Upload Pictures:',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        setHeight(10),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          children: List<Widget>.generate(
                              con.imageList.length > 10
                                  ? 10
                                  : con.imageList.length, (index) {
                            final item = con.imageList[index];

                            return GridTile(
                              child: DottedBorder(
                                color: AppColors.gray.lightColorHex(),
                                padding: const EdgeInsets.all(1),
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(20),
                                child: item.isUplaod
                                    ? Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image(
                                              width: double.maxFinite,
                                              height: double.maxFinite,
                                              image: FileImage(
                                                File('${item.file?.path}'),
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () {
                                                con.deleteImage(index);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: AppColors.red
                                                      .lightColorHex(),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : InkWell(
                                        onTap: () {
                                          _bottomsheetWithDocumentOptions(
                                            selectedOption: (status) {
                                              NavigationService()
                                                  .setPopNavigator();
                                              _openImagePicker(status,
                                                  selectedFile: (file) {
                                                if (file != null) {
                                                  con.addImage(file);
                                                }
                                              });
                                            },
                                          );
                                        },
                                        child: Center(
                                          child: Icon(
                                            Icons.photo_camera_rounded,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                              ),
                            );
                          }),
                        ),
                        setCommonText(
                          'Upload Video:',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        setHeight(6),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            DottedBorder(
                              color: Colors.grey.shade500,
                              strokeWidth: 1,
                              child: SizedBox(
                                width: double.infinity,
                                height: 180,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      // _bottomsheetWithDocumentOptions(
                                      //   selectedOption: (status) {
                                      //     controller
                                      //         .selectDocumentOption(status);
                                      //     NavigationService().setPopNavigator();
                                      //     _openImagePicker(status,
                                      //         selectedFile: (file) {
                                      //       con.addImage(file);
                                      //     });
                                      //   },
                                      // );
                                      //Video
                                      ImagePicker()
                                          .pickVideo(
                                              source: ImageSource.gallery)
                                          .then((value) async {
                                        log('Selected Video Path is:${value?.path}');
                                        if (value != null) {
                                          final controller =
                                              Get.put(DisputeConctroller());
                                          controller.updateLoading();
                                          final thumbnilImg =
                                              await SharedManager()
                                                  .getVideoThumbnail(
                                                      value.path);
                                          controller.updateLoading();
                                          if (thumbnilImg != null) {
                                            controller.updateImagePath(
                                              thumbnilImg,
                                              vdPath: value,
                                            );
                                          }
                                        }
                                      });
                                    },
                                    child: (con.imagePath == '')
                                        ? Icon(
                                            Icons.camera_alt,
                                            color: AppColors.gray_mid
                                                .lightColorHex(),
                                          )
                                        : Image(
                                            width: double.maxFinite,
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(con.imagePath),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            if (con.isLoadingVideo)
                              CircularProgressIndicator(
                                color:
                                    AppColors.colorPrimaryDark.lightColorHex(),
                              )
                          ],
                        ),
                        setHeight(20),
                      ],
                    ),
                  ),
                ),
                setHeight(10),
                createButton(
                    hideGradient: true,
                    btnColour: AppColors.colorPrimaryDark.lightColorHex(),
                    text: 'SUBMIT',
                    txtColor: AppColors.white.lightColorHex(),
                    height: 50,
                    weightFont: FontWeight.w600,
                    onBtnClick: () {
                      //Submit
                      // controller.uploadDocumentsOnServer();
                      con.submitDisputeRequest(widget.taskDetails, context);
                    }),
              ],
            ),
          );
        },
      ),
    );
  }

  _openImagePicker(bool status, {Function(XFile?)? selectedFile}) {
    //Image
    ImagePicker()
        .pickImage(source: status ? ImageSource.gallery : ImageSource.camera)
        .then((value) {
      //
      log('Selected Image Path is:${value?.path}');
      selectedFile?.call(value);
    });
  }

  _bottomsheetWithDocumentOptions({Function(bool)? selectedOption}) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SizedBox(
            child: BottomSheetWithDocOptions(
              onSelectOption: (status) {
                selectedOption?.call(status);
              },
            ),
          );
        });
  }

  _setCommonWidgetTitleWithValue({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setCommonText(
          title,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        setCommonText(
          value,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.gray_mid.lightColorHex(),
          noOfLine: 20,
        ),
        const Divider()
      ],
    );
  }
}
