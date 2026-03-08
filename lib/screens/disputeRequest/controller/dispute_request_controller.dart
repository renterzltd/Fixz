import 'dart:developer' as logs;
import 'dart:io';
import 'dart:math';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';

class DisputeConctroller extends GetxController {
  //
  bool isImage = true;
  bool isLoadingVideo = false;
  String imagePath = '';
  XFile? videoFile;

  TextEditingController description = TextEditingController();

  List<DISPUTEDOC> imageList = [
    DISPUTEDOC(isUplaod: false),
  ];

  void selectDocumentOption(bool status) {
    isImage = status;
    update();
  }

  void updateImagePath(String image, {XFile? vdPath}) {
    imagePath = image;
    videoFile = vdPath;
    update();
  }

  void updateLoading() {
    isLoadingVideo = !isLoadingVideo;
    update();
  }

  //Image Operation

  void addImage(XFile? file) {
    imageList.insert(0, DISPUTEDOC(isUplaod: true, file: file));
    update();
  }

  void deleteImage(int index) {
    imageList.removeAt(index);
    update();
  }

  //API CALL

  void submitDisputeRequest(TaskDetailData? taskDetails, BuildContext context) {
    if (description.text.isEmpty) {
      AlertClass.shared.setSnackbar('Please write description first');
      return;
    }
    final filterList = imageList.where((element) => element.isUplaod).toList();
    List<File> images = [];
    for (DISPUTEDOC docs in filterList) {
      if (docs.file != null) {
        images.add(File(docs.file!.path));
      }
    }
    ApiProvider()
        .submitDispureRequest(
      images,
      '${taskDetails?.id}',
      '${taskDetails?.acceptedQuotation?.quotationId}',
      description.text,
      videoPath: videoFile,
    )
        .then((value) {
      if (value.message?.toLowerCase() == 'success') {
        AlertClass.shared
            .setSnackbar('Dispute request submitted successfully!!');
        Navigator.of(context).pop('yes');
      }
    });
  }
}

class DISPUTEDOC {
  XFile? file;
  bool isUplaod;
  DISPUTEDOC({
    required this.isUplaod,
    this.file,
  });
}
