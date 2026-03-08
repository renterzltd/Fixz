// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// bool _wrongEmail = false;
// bool _wrongPassword = false;

// User? _user;

// // ignore: must_be_immutable
// class LoginPage extends StatefulWidget {
//   static String id = '/LoginPage';

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String? email;
//   String? password;

//   bool _showSpinner = false;

//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<User> _handleSignIn() async {
//     // hold the instance of the authenticated user
// //    FirebaseUser user;
//     // flag to check whether we're signed in already
//     bool isSignedIn = await _googleSignIn.isSignedIn();
//     if (isSignedIn) {
//       // if so, return the current user
//       _user = await _auth.currentUser;
//     } else {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser!.authentication;
//       // get the credentials to (access / id token)
//       // to sign in via Firebase Authentication
//       final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//       _user = (await _auth.signInWithCredential(credential)).user;
//     }

//     return _user!;
//   }

//   void onGoogleSignIn(BuildContext context) async {
//     await _googleSignIn.signOut();
//     setState(() {
//       _showSpinner = true;
//     });

//     User user = await _handleSignIn();
//     log('User Email ${user.email}');
//     log('User displayName ${user.displayName}');
//     log('User:  $user');
//     setState(() {
//       _showSpinner = true;
//     });
//   }

//   String emailText = 'Email doesn\'t match';
//   String passwordText = 'Password doesn\'t match';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Align(
//             alignment: Alignment.topRight,
//             child: Image.asset('assets/images/background.png'),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//                 top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Login',
//                   style: TextStyle(fontSize: 50.0),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome back,',
//                       style: TextStyle(fontSize: 30.0),
//                     ),
//                     Text(
//                       'please login',
//                       style: TextStyle(fontSize: 30.0),
//                     ),
//                     Text(
//                       'to your account',
//                       style: TextStyle(fontSize: 30.0),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     TextField(
//                       keyboardType: TextInputType.emailAddress,
//                       onChanged: (value) {
//                         email = value;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Email',
//                         labelText: 'Email',
//                         errorText: _wrongEmail ? emailText : null,
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     TextField(
//                       obscureText: true,
//                       keyboardType: TextInputType.visiblePassword,
//                       onChanged: (value) {
//                         password = value;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Password',
//                         labelText: 'Password',
//                         errorText: _wrongPassword ? passwordText : null,
//                       ),
//                     ),
//                     SizedBox(height: 10.0),
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: GestureDetector(
//                         onTap: () {},
//                         child: Text(
//                           'Forgot Password?',
//                           style: TextStyle(fontSize: 20.0, color: Colors.blue),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Container(
//                         height: 1.0,
//                         width: 60.0,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     Text(
//                       'Or',
//                       style: TextStyle(fontSize: 25.0),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Container(
//                         height: 1.0,
//                         width: 60.0,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: RaisedButton(
//                         padding: EdgeInsets.symmetric(vertical: 5.0),
//                         color: Colors.white,
//                         shape: ContinuousRectangleBorder(
//                           side: BorderSide(
//                               width: 0.5, color: Colors.grey.shade400),
//                         ),
//                         onPressed: () {
//                           onGoogleSignIn(context);
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset('assets/images/google.png',
//                                 fit: BoxFit.contain, width: 40.0, height: 40.0),
//                             Text(
//                               'Google',
//                               style: TextStyle(
//                                   fontSize: 25.0, color: Colors.black),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 20.0),
//                     // Expanded(
//                     //   child: RaisedButton(
//                     //     padding: EdgeInsets.symmetric(vertical: 5.0),
//                     //     color: Colors.white,
//                     //     shape: ContinuousRectangleBorder(
//                     //       side: BorderSide(
//                     //           width: 0.5, color: Colors.grey.shade400),
//                     //     ),
//                     //     onPressed: () {
//                     //       //TODO: Implement facebook functionality
//                     //     },
//                     //     child: Row(
//                     //       mainAxisAlignment: MainAxisAlignment.center,
//                     //       children: [
//                     //         Image.asset('assets/images/facebook.png',
//                     //             fit: BoxFit.cover, width: 40.0, height: 40.0),
//                     //         // ignore: prefer_const_constructors
//                     //         Text(
//                     //           'Facebook',
//                     //           style: TextStyle(
//                     //               fontSize: 25.0, color: Colors.black),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // ignore: prefer_const_constructors
//                     Text(
//                       'Don\'t have an account?',
//                       style: TextStyle(fontSize: 25.0),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Text(
//                         ' Sign Up',
//                         style: TextStyle(fontSize: 25.0, color: Colors.blue),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
