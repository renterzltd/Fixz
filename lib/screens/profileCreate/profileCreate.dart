// ignore_for_file: unused_element, unnecessary_this, prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({Key? key}) : super(key: key);

  @override
  State<ProfileCreation> createState() => _ProfileCreationState();
}

class _ProfileCreationState extends State<ProfileCreation>
    with AppbarMixin, TextFieldMixin, ButtonMixin {
  bool isSelectTings = false;
  bool isSelectMoney = false;
  bool isCheck = false;
  final controller = Get.put(LoginController());

  //Methods
  _setComonWidget(String name, String hint, TextEditingController controller,
      {bool isEditable = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setCommonText(
          name,
          fontSize: 14,
          color: AppColors.black.lightColorHex(),
          fontWeight: FontWeight.w500,
        ),
        setHeight(8),
        setTextField(
          isEditable: isEditable,
          controller: controller,
          height: 40,
          hint: hint,
          hintColor: AppColors.gray.lightColorHex(),
          fontSize: 14,
          isLabelHidden: true,
          isVisibleBorder: false,
          keyboardType: TextInputType.emailAddress,
          isSecureText: false,
        ),
      ],
    );
  }

  _mainGoalWidgets() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          setCommonText(
            'What is your main goal on Fixz?'.tr,
            fontSize: 14,
            color: AppColors.black.lightColorHex(),
            fontWeight: FontWeight.w500,
          ),
          setHeight(5),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isSelectMoney = false;
                      isSelectTings = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: isSelectTings
                              ? AppColors.colorPrimary.lightColorHex()
                              : Colors.black45,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_alt_outlined,
                          color: isSelectTings
                              ? AppColors.colorPrimary.lightColorHex()
                              : Colors.black45,
                        ),
                        setHeight(5),
                        setCommonText(
                          'Get things done'.tr,
                          fontSize: 14,
                          color: isSelectTings
                              ? AppColors.colorPrimary.lightColorHex()
                              : Colors.black45,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              setWidth(10),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isSelectMoney = true;
                      isSelectTings = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: isSelectMoney
                              ? AppColors.colorPrimary.lightColorHex()
                              : Colors.black45,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          color: isSelectMoney
                              ? AppColors.colorPrimary.lightColorHex()
                              : Colors.black45,
                        ),
                        setHeight(5),
                        setCommonText(
                          'Earn Money'.tr,
                          fontSize: 14,
                          color: isSelectMoney
                              ? AppColors.colorPrimary.lightColorHex()
                              : Colors.black45,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _setDonotProductUpdate() {
    return InkWell(
      onTap: () {
        setState(() {
          this.isCheck = !this.isCheck;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(this.isCheck ? Icons.check_box : Icons.check_box_outline_blank),
          setWidth(5),
          Expanded(
            child: setCommonText(
              'I do not want to receive prodcut update or marketing material'
                  .tr,
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              noOfLine: 3,
            ),
          )
        ],
      ),
    );
  }

  _showAutocomplete() async {
    LocationResult result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          mapKey,
        ),
      ),
    );
    if (!mounted) return;
    controller.addPostalCode(result.formattedAddress ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setAppbar('Create your profile'.tr,
            bgColor: AppColors.white.lightColorHex(),
            elivation: 1.0,
            onBackClick: () {}),
        body: Container(
          padding: EdgeInsets.all(20),
          color: AppColors.white.lightColorHex(),
          child: GetBuilder<LoginController>(
            builder: (con) {
              return ListView(
                children: [
                  _setComonWidget(
                      'First Name'.tr, 'First Name'.tr, controller.signupFname),
                  setHeight(20),
                  _setComonWidget(
                      'Last Name'.tr, 'Last Name'.tr, controller.signupLname),
                  setHeight(20),
                  if (!SharedManager.shared.isDubaiVersion)
                    InkWell(
                      onTap: () {
                        _showAutocomplete();
                      },
                      child: _setComonWidget('Enter your home post code'.tr,
                          'Enter Postcode'.tr, con.postalCodeController,
                          isEditable: false),
                    ),
                  // setHeight(20),
                  // _mainGoalWidgets(),
                  // setHeight(20),
                  // _setDonotProductUpdate(),
                  setHeight(30),
                  createButton(
                      text: 'Complete your account'.tr,
                      txtColor: AppColors.white.lightColorHex(),
                      onBtnClick: () {
                        controller.makeSignUp();
                      }),
                ],
              );
            },
          ),
        ));
  }
}
