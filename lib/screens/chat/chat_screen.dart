// ignore_for_file: must_be_immutable, library_private_types_in_public_api, use_key_in_widget_constructors, unnecessary_this, avoid_print, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:fixz/hdHelper/base_widget.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/chat/bottom_sheet_with_image.dart';
import 'package:fixz/screens/chat/chat_screen_model.dart';
import 'package:fixz/util/r.g.dart';

class ChatPage extends StatefulWidget {
  final UserChat _userChat;
  bool isChatFromRequestviewing;
  @override
  _ChatPageState createState() => _ChatPageState();

  ChatPage(this._userChat, {this.isChatFromRequestviewing = false});
}

class _ChatPageState extends State<ChatPage> with AppbarMixin {
  String message = "";
  var textEditingController = TextEditingController();
  late Timer timer;
  bool isFirstTimeLoading = true;

  @override
  void initState() {
    super.initState();
    debugPrint("from type:${this.widget._userChat.userId}");
    debugPrint("TO type: ===>${this.widget._userChat.name}");
    if (this.widget._userChat.toType == 'LANDLORD') {
      this.widget.isChatFromRequestviewing = true;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.timer.cancel();
  }

  appBarWithBack(title, context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.black.lightColorHex(),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openBottomsheetForDocuments(ChatScreenModel model) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SelectImageWithOptions(
            selectPicture: (val) async {
              if (val) {
                XFile? imgFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (imgFile != null) {
                  //Upload it
                  File finalFile = File(imgFile.path);
                  // dio.MultipartFile? image = await fileToMultiPart(finalFile);
                  // log('called image method');
                  // UploadMsgDocumentRequestModel model =
                  //     UploadMsgDocumentRequestModel(file: image);
                  sendImage(finalFile, model);
                }
              } else {
                XFile? imgFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (imgFile != null) {
                  File finalFile = File(imgFile.path);
                  //Upload it
                  // dio.MultipartFile? image =
                  //     await fileToMultiPart(File(imgFile.path));
                  // UploadMsgDocumentRequestModel model =
                  //     UploadMsgDocumentRequestModel(file: image);
                  sendImage(finalFile, model);
                }
              }
            },
          );
        });
  }

  void sendImage(File image, ChatScreenModel model) async {
    await EasyLoading.show(status: 'Sending...'.tr);
    ApiResponse response = await model.sendMessageToUserWithImage(
        widget._userChat.userId!,
        message,
        widget.isChatFromRequestviewing,
        image);
    setState(() {
      message = "";
      textEditingController.text = "";
    });
    if (response.isCompleted()) {
      await EasyLoading.dismiss();
      model.getChat(
          widget._userChat.userId!, this.widget.isChatFromRequestviewing);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChatScreenModel>(
      model: ChatScreenModel(Provider.of(context)),
      onModelReady: (model) async {
        if (isFirstTimeLoading) {
          await EasyLoading.show(status: 'Loading...'.tr);
        }
        model
            .getChat(
                widget._userChat.userId!, this.widget.isChatFromRequestviewing)
            .then((value) {
          setState(() {
            isFirstTimeLoading = false;
            //   model.list.clear();
            //   model.list.addAll(value.data);
          });
        });
        timer = Timer.periodic(Duration(seconds: 3), (timer) {
          model
              .getChat(widget._userChat.userId!,
                  this.widget.isChatFromRequestviewing)
              .then((value) {
            // if (model.list.first.id != value.data.first.id) {
            //   model.list.clear();
            //   model.list.addAll(value.data);
            setState(() {});
            // }
          });
        });
      },
      builder: (BuildContext context, ChatScreenModel model, Widget? child) {
        return Scaffold(
          appBar: setAppbar(
            widget._userChat.name ?? '',
            bgColor: AppColors.colorPrimaryDark.lightColorHex(),
            isTitleCenter: true,
            backIconColor: Colors.white,
            textColor: Colors.white,
          ),
          //  extendBodyBehindAppBar: true,
          body: Column(
            children: <Widget>[
              Expanded(
                child: buildList(model),
              ),
              Container(
                // color: Colors.red,
                padding: EdgeInsets.fromLTRB(16, 3, 16, 10),
                // height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  AppColors.colorPrimaryDark.lightColorHex()),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write here...'.tr,
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                            ),
                            onChanged: (value) {
                              message = value;
                              textEditingController.value = TextEditingValue(
                                text: value,
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: value.length),
                                ),
                              );
                            },
                            maxLines: 2,
                            controller: textEditingController),
                      ),
                    ),
                    setWidth(5),
                    GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (message != "") {
                            await EasyLoading.show(status: 'Sending...'.tr);
                            ApiResponse response =
                                await model.sendMessageToUser(
                                    widget._userChat.userId!,
                                    message,
                                    widget.isChatFromRequestviewing);
                            setState(() {
                              message = "";
                              textEditingController.text = "";
                            });
                            if (response.isCompleted()) {
                              await EasyLoading.dismiss();
                              model.getChat(widget._userChat.userId!,
                                  this.widget.isChatFromRequestviewing);
                            }
                            setState(() {});
                          } else {
                            AlertClass.shared
                                .shoAlertWindow('Please write some message'.tr);
                          }
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    AppColors.colorPrimaryDark.lightColorHex()),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.send,
                            size: 18,
                            color: AppColors.colorPrimaryDark.lightColorHex(),
                          ),
                        )),
                    setWidth(5),
                    GestureDetector(
                        onTap: () async {
                          openBottomsheetForDocuments(model);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    AppColors.colorPrimaryDark.lightColorHex()),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image,
                            size: 18,
                            color: AppColors.colorPrimaryDark.lightColorHex(),
                          ),
                        )),
                  ],
                ),
              ),
              setHeight(10),
            ],
          ),
        );
      },
    );
  }

  Widget buildList(ChatScreenModel model) {
    return Container(
      color: AppColors.white.lightColorHex(),
      child: ListView.builder(
          padding: EdgeInsets.all(0.0),
          shrinkWrap: true,
          itemCount: model.list.length,
          reverse: true,
          itemBuilder: (BuildContext context, int index) {
            final obj = model.list[index];
            return _buildDataCell(context, obj, model);
          }),
    );
  }

  Widget _buildDataCell(
      BuildContext context, UserChat item, ChatScreenModel model) {
    if (item.to == widget._userChat.userId)
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Container()),
                (item.imageMsg != null && item.imageMsg != '')
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            NavigationService().setNavigator(
                              ZoomableImagePage(
                                images: [item.imageMsg!],
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: item.imageMsg!,
                            height: MediaQuery.sizeOf(context).width * 0.40,
                            width: MediaQuery.sizeOf(context).width * 0.40,
                            progressIndicatorBuilder: (context, url, progress) {
                              return Align(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 4,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                item.body ?? "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.black.lightColorHex(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10000.0),
                    child: CachedNetworkImage(
                      imageUrl: item.to == widget._userChat.userId!
                          ? model.user?.image ?? ''
                          : item.image!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.red, BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        R.image.ic_circle_user().assetName,
                        height: 50,
                        fit: BoxFit.fill,
                        width: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    else
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          //  crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10000.0),
                    child: CachedNetworkImage(
                      // imageUrl: item.fromType == "LANDLORD"
                      imageUrl: item.to == widget._userChat.userId!
                          ? model.user?.image ?? ''
                          : item.image!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Image.asset(
                        R.image.ic_circle_user().assetName,
                        height: 50,
                        fit: BoxFit.fill,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                (item.imageMsg != null && item.imageMsg != '')
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            NavigationService().setNavigator(
                              ZoomableImagePage(
                                images: [item.imageMsg!],
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: item.imageMsg!,
                            height: MediaQuery.sizeOf(context).width * 0.40,
                            width: MediaQuery.sizeOf(context).width * 0.40,
                            progressIndicatorBuilder: (context, url, progress) {
                              return Align(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.body ?? "",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.black.lightColorHex(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      );
  }
}
