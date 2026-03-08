// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_constructors, avoid_print

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  bool isLogin = false;
  ApiProvider _apiProvider = ApiProvider();
  TextEditingController? numberController;
  TextEditingController? otpController;
  String token = '';
  String countryCode = !SharedManager.shared.isDubaiVersion ? "+44" : "+971";
  //Signup stuff
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupMobile = TextEditingController();
  TextEditingController signupFname = TextEditingController();
  TextEditingController signupLname = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

//Social Signin

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  selectCountryCode(String code) {
    countryCode = code;
    update();
  }

  // clearAll() {
  //   isLogin = false;
  // }

  String _checkMobileValidator(String number) {
    // if (number.characters.first == '0') {
    //   return number;
    // } else {
    //   return '0$number';
    // }
    final mobileNumber = '$countryCode${int.parse(number).toString()}';
    log('Final Mobile Number:$mobileNumber');
    return mobileNumber;
  }

  addPostalCode(String address) {
    postalCodeController.text = address;
    update();
  }

  makeLogin() async {
    if (numberController?.text.isEmpty ?? false) {
      AlertClass.shared.setSnackbar('Please enter valid phone number'.tr);
      return;
    }
    //  else if (numberController.text.length <= 8) {
    //   AlertClass.shared.setSnackbar('Invalid mobile number'.tr);
    //   return;
    // }
    await EasyLoading.show(status: 'Loading...'.tr);
    await _apiProvider
        .login(_checkMobileValidator(numberController?.text ?? ''), token)
        .then((value) async {
      await EasyLoading.dismiss();
      if (value.status == Status.COMPLETED && value.data != null) {
        log('***************************LOGIN RESPONSE*****************************\n${value.data.token}');
        token = value.data.token;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessTokenKey', value.data.token);
        isLogin = true;
        update();
      } else {
        AlertClass.shared.setSnackbar(value.message);
      }
    });
  }

  makeSignUp() async {
    if (signupFname.text.isEmpty) {
      AlertClass.shared.setSnackbar('Please enter first name'.tr);
      return;
    } else if (signupLname.text.isEmpty) {
      AlertClass.shared.setSnackbar('Please enter last name'.tr);
      return;
    } else if (postalCodeController.text.isEmpty &&
        !SharedManager.shared.isDubaiVersion) {
      AlertClass.shared.setSnackbar('Please enter postal code'.tr);
      return;
    }

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings notificationSettings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true, provisional: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   debugPrint("Settings registered: $settings");
    // });

    _firebaseMessaging.getToken().then((token) {
      EasyLoading.show(status: 'Loading...'.tr);
      debugPrint("***************FCM TOKEN*************$token");
      _apiProvider
          .signup(signupEmail.text, _checkMobileValidator(signupMobile.text),
              '${signupFname.text} ${signupLname.text}', '', token ?? "",
              postalCode: postalCodeController.text)
          .then((value) async {
        EasyLoading.dismiss();
        if (value.status == Status.COMPLETED) {
          log('***************************Signup RESPONSE*****************************\n${value.data.token}');
          token = value.data.token;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessTokenKey', value.data.token);
          otpController?.clear();
          isLogin = true;
          clearSignUpData();
          NavigationService().setNavigator(HomeviewerLogin());
          update();
        } else {
          AlertClass.shared.setSnackbar(value.message);
        }
      });
    });

    // NavigationService().setNavigator(TaskScreen());
  }

  clearSignUpData() {
    signupEmail.clear();
    signupMobile.clear();
    signupFname.clear();
    signupLname.clear();
    update();
  }

  verifyOTP() async {
    // String token = prefs.getString('accessTokenKey') ?? '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorageProvider localStorage = LocalStorageProvider(prefs);
    token = prefs.getString('accessTokenKey')!;
    log("****************TOKEN***************$token");
    if (otpController?.text.isEmpty ?? false) {
      AlertClass.shared.setSnackbar('Please enter valid phone number'.tr);
      return;
    }
    await EasyLoading.show(status: 'Loading...'.tr);
    await _apiProvider
        .verify(otpController?.text ?? '', token)
        .then((value) async {
      await EasyLoading.dismiss();
      log('***************************Verify OTP RESPONSE*****************************\n$value');
      if (value.status == Status.COMPLETED && value.data != null) {
        Future.delayed(Duration(milliseconds: 400), () async {
          await prefs.setString('isHomeViewerLogin', 'yes');
          //Store user data
          MyUser myUser = value.data;
          await localStorage.saveUser(myUser);
          await localStorage.saveUserImage(myUser.image!);
          await storeValue(key: DEFAULTKEYS.userName, value: myUser.name ?? '');
          isLogin = false;
          otpController?.clear();
          numberController?.clear();
          clearOTPController();
          clearData();
          update();
          NavigationService()
              .setNavigator(HomeTabbarScreen(), isRemoveAll: true);
        });
      }
    });
  }

  resendOTP() async {
    //pending
    clearOTPController();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('accessTokenKey')!;
    log("****************TOKEN***************$token");
    await EasyLoading.show(status: 'Loading...'.tr);
    await _apiProvider.resendVerfiyCode(token).then((value) async {
      await EasyLoading.dismiss();
      AlertClass.shared.setSnackbar('OTP sent successfully!!');
    });
  }

  clearOTPController() {
    otpController?.clear();
    codeSMS = '';
    update();
  }

  clearData() {
    numberController?.clear();
    isLogin = false;
    update();
  }

  continueToUserCreations() {
    if (signupEmail.text.isEmpty) {
      AlertClass.shared.setSnackbar('Please enter valid email address'.tr);
      return;
    } else if (!signupEmail.text.isEmail) {
      AlertClass.shared.setSnackbar('Invalid email'.tr);
      return;
    } else if (signupMobile.text.isEmpty) {
      AlertClass.shared.setSnackbar('Please enter valid phone number'.tr);
      return;
    }
    // else if (signupMobile.text.length <= 8) {
    //   AlertClass.shared.setSnackbar('Invalid mobile number'.tr);
    //   return;
    // }
    NavigationService().setNavigator(ProfileCreation());
  }

  //MARK: Google Sign In

  Future<User> _handleSignIn() async {
    bool isSignedIn = await SharedManager.shared.googleSignIn.isSignedIn();
    if (isSignedIn) {
      _user = _auth.currentUser;
    } else {
      final GoogleSignInAccount? googleUser =
          await SharedManager.shared.googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      _user = (await _auth.signInWithCredential(credential)).user;
    }

    return _user!;
  }

  onGoogleSignIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorageProvider localStorage = LocalStorageProvider(prefs);

    await SharedManager.shared.googleSignIn.signOut();
    User user = await _handleSignIn();
    log('User Email ${user.email}');
    log('User displayName ${user.displayName}');
    log('User:  $user');
    final userParam = {
      'name': user.displayName ?? '',
      'email': user.email ?? '',
      'social_id': user.uid,
      'image_url': user.photoURL ?? '',
      'mobile_number': user.phoneNumber ?? '',
    };

    // await _apiProvider.loginWithSocialMedia(userParam).then((value) async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('accessTokenKey', value.data!.token!);
    //   await prefs.setString('isHomeViewerLogin', 'yes');
    //   SharedManager.shared.isSocialLogin = true;
    //   NavigationService().setNavigator(HomeTabbarScreen(), isRemoveAll: true);
    // });
    MyUser myUser = MyUser();
    myUser.email = user.email;
    myUser.image = user.photoURL;
    myUser.mobileNumber = user.phoneNumber;
    myUser.name = user.displayName;
    await localStorage.saveUser(myUser);
    await localStorage.saveUserImage(myUser.image!);

    await storeValue(key: DEFAULTKEYS.userName, value: user.displayName ?? '');
    _loginWithSocialMedia(userParam);
  }

  loginWithApple() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorageProvider localStorage = LocalStorageProvider(prefs);
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ],
    );

    debugPrint('Login with Apple:$credential');
    debugPrint('Login with Apple:${credential.authorizationCode}');
    debugPrint('Login with Apple:${credential.identityToken}');
    debugPrint('Login with Apple:${credential.state}');
    debugPrint('Login with Apple:${credential.userIdentifier}');

    var userParam = {
      'name': credential.givenName ?? '',
      'social_id': credential.userIdentifier ?? '',
      'image_url': '',
      'mobile_number': '',
    };
    if (credential.email != null) {
      userParam['email'] = credential.email!;
    }
    log('Social Media response:$userParam');

    MyUser myUser = MyUser();
    myUser.email = credential.email ?? '';
    myUser.image = '';
    myUser.mobileNumber = '';
    myUser.name = credential.givenName ?? 'Apple';
    await localStorage.saveUser(myUser);
    await localStorage.saveUserImage(myUser.image!);

    await storeValue(
        key: DEFAULTKEYS.userName, value: credential.givenName ?? 'Apple');

    _loginWithSocialMedia(userParam);
  }

  _loginWithSocialMedia(Map<String, dynamic> param) async {
    try {
      await _apiProvider.loginWithSocialMedia(param).then(
        (value) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessTokenKey', value.data?.token ?? '');
          await prefs.setString('isHomeViewerLogin', 'yes');
          SharedManager.shared.isSocialLogin = true;
          NavigationService()
              .setNavigator(HomeTabbarScreen(), isRemoveAll: true);
        },
      );
    } on Exception catch (error) {
      print(error.toString());
      throw Exception('Login with apple gives error: $error');
    }
  }
}
