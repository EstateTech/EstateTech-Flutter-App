import 'package:crypto_estate_tech/common/own_firebase_auth.dart';
import 'package:crypto_estate_tech/screens/AuthScreens/otpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/widgetConstants.dart';

class AuthProvider extends ChangeNotifier {
   bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
    bool _isLoading = false;
  bool get isLoading => _isLoading;
    String? _uid;
  String get uid => _uid!;


    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


    AuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  
   // signin
  Future signInWithPhone(BuildContext context, String phoneNumber,String dialCode) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
              _isLoading = false;
              notifyListeners();
          },
          verificationFailed: (error) {
             _isLoading = false;
              notifyListeners();
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.pop(context);
           
           
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  verificationId: verificationId,
                  phoneNumber : phoneNumber,
                  dialCode : dialCode
                  
                  ),
              ),
              
            );
           
             
          },
          codeAutoRetrievalTimeout: (verificationId) {
              _isLoading = false;
              notifyListeners();
          });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
        _isLoading = false;
              notifyListeners();
    }
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        //own your logic
        _uid = user.uid;
        onSuccess();
      }
     
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future LogOut() async {
      _isLoading = false;
    notifyListeners();
    await FirebaseAuth.instance.signOut();
  

  }






}