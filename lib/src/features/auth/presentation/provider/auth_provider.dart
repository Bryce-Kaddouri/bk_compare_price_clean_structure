import 'package:bk_compare_price_mvc/src/features/auth/business/param/reset_password_param.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/usecase/get_current_user_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/usecase/send_password_reset_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/usecase/signin_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/usecase/signout_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/usecase/signup_usecase.dart';
import 'package:flutter/material.dart';

import '../../business/param/signin_param.dart';
import '../../business/param/signup_param.dart';
import '../../data/model/user_model.dart';

class AuthenticationProvider with ChangeNotifier {
  final SigninUseCase signinUseCase;
  final SignupUsecase signupUseCase;
  final SendResetPasswordUseCase sendResetPasswordUseCase;
  final SignoutUseCase signoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthenticationProvider({
    required this.signinUseCase,
    required this.signupUseCase,
    required this.sendResetPasswordUseCase,
    required this.signoutUseCase,
    required this.getCurrentUserUseCase,
  });

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  final TextEditingController _emailSigninController = TextEditingController();
  TextEditingController get emailSigninController => _emailSigninController;

  final TextEditingController _passwordSigninController = TextEditingController();
  TextEditingController get passwordSigninController => _passwordSigninController;

  final TextEditingController _nameSignupController = TextEditingController();
  TextEditingController get nameSignupController => _nameSignupController;

  final TextEditingController _emailSignupController = TextEditingController();
  TextEditingController get emailSignupController => _emailSignupController;

  final TextEditingController _passwordSignupController = TextEditingController();
  TextEditingController get passwordSignupController => _passwordSignupController;

  final TextEditingController _confirmPasswordSignupController = TextEditingController();
  TextEditingController get confirmPasswordSignupController => _confirmPasswordSignupController;

  final TextEditingController _emailResetPasswordController = TextEditingController();
  TextEditingController get emailResetPasswordController => _emailResetPasswordController;




  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  String? _signinEmailErrorMessage;
  String? get signinEmailErrorMessage => _signinEmailErrorMessage;

  void setSigninEmailErrorMessage(String? message) {
    _signinEmailErrorMessage = message;
    notifyListeners();
  }

  String? _signinPasswordErrorMessage;
  String? get signinPasswordErrorMessage => _signinPasswordErrorMessage;

  void setSigninPasswordErrorMessage(String? message) {
    _signinPasswordErrorMessage = message;
    notifyListeners();
  }

  String? _signupEmailErrorMessage;
  String? get signupEmailErrorMessage => _signupEmailErrorMessage;

  void setSignupEmailErrorMessage(String? message) {
    _signupEmailErrorMessage = message;
    notifyListeners();
  }

  String? _signupPasswordErrorMessage;
  String? get signupPasswordErrorMessage => _signupPasswordErrorMessage;

  void setSignupPasswordErrorMessage(String? message) {
    _signupPasswordErrorMessage = message;
    notifyListeners();
  }

  String? _signupConfirmPasswordErrorMessage;
  String? get signupConfirmPasswordErrorMessage => _signupConfirmPasswordErrorMessage;

  void setSignupConfirmPasswordErrorMessage(String? message) {
    _signupConfirmPasswordErrorMessage = message;
    notifyListeners();
  }



  String? _resetPasswordEmailErrorMessage;
  String? get resetPasswordEmailErrorMessage => _resetPasswordEmailErrorMessage;

  void setResetPasswordEmailErrorMessage(String? message) {
    _resetPasswordEmailErrorMessage = message;
    notifyListeners();
  }

  String? _signinErrorMessage;
  String? get signinErrorMessage => _signinErrorMessage;

  void setSigninErrorMessage(String? message) {
    _signinErrorMessage = message;
    notifyListeners();
  }

  String? _signoutErrorMessage;
  String? get signoutErrorMessage => _signoutErrorMessage;

  void setSignoutErrorMessage(String? message) {
    _signoutErrorMessage = message;
    notifyListeners();
  }

  String? _getCurrentUserErrorMessage;
  String? get getCurrentUserErrorMessage => _getCurrentUserErrorMessage;

  void setGetCurrentUserErrorMessage(String? message) {
    _getCurrentUserErrorMessage = message;
    notifyListeners();
  }

  String? _signupErrorMessage;
  String? get signupErrorMessage => _signupErrorMessage;

  void setSignupErrorMessage(String? message) {
    _signupErrorMessage = message;
    notifyListeners();
  }

  String? _resetPasswordErrorMessage;
  String? get resetPasswordErrorMessage => _resetPasswordErrorMessage;

  void setResetPasswordErrorMessage(String? message) {
    _resetPasswordErrorMessage = message;
    notifyListeners();
  }

  Future<bool> signin(String email, String password) async {
    try {
      setIsLoading(true);
      setSigninErrorMessage(null);
      final user = await signinUseCase(SigninParam(email: email, password: password));
      print('user: $user');
      setCurrentUser(user);
      setIsLoading(false);
      return true;
    } catch (e) {
      setIsLoading(false);
      setSigninErrorMessage(e.toString());
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password) async {
    try {
      setIsLoading(true);
      setSignupErrorMessage(null);
      final user = await signupUseCase(SignupParam(name: name, email: email, password: password));
      setCurrentUser(user);
      setIsLoading(false);
      return true;
    } catch (e) {
      setIsLoading(false);
      setSignupErrorMessage(e.toString());
      return false;
    }
  }

  Future<bool> sendResetPassword(String email) async {
    try {
      setIsLoading(true);
      setResetPasswordErrorMessage(null);
      await sendResetPasswordUseCase(ResetPasswordParam(email: email));
      setIsLoading(false);
      return true;
    } catch (e) {
      setIsLoading(false);
      setResetPasswordErrorMessage(e.toString());
      return false;
    }
  }

  Future<bool> signout() async {
    try {
      setIsLoading(true);
      setSignoutErrorMessage(null);
      await signoutUseCase();
      setCurrentUser(null);
      setIsLoading(false);
      return true;
    } catch (e) {
      setIsLoading(false);
      setSignoutErrorMessage(e.toString());
      return false;
    }
  }

  Future<bool> getCurrentUser() async {
    try {
      setIsLoading(true);
      setGetCurrentUserErrorMessage(null);
      final user = await getCurrentUserUseCase();
      setCurrentUser(user);
      setIsLoading(false);
      return true;
    } catch (e) {
      setIsLoading(false);
      setGetCurrentUserErrorMessage(e.toString());
      return false;
    }
  }

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  void setObscureText(bool obscureText) {
    _obscureText = obscureText;
    notifyListeners();
  }

  validateEmail(String s) {
    if (s.isEmpty) {
      setSigninEmailErrorMessage('Email is required');
      return false;
    } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(s)) {
      setSigninEmailErrorMessage('Email is invalid');
      return false;
    } else {
      setSigninEmailErrorMessage(null);
      return true;
    }
  }

  validatePassword(String s) {
    if (s.isEmpty) {
      setSigninPasswordErrorMessage('Password is required');
      return false;
    } else if (s.length < 6) {
      setSigninPasswordErrorMessage('Password must be at least 6 characters');
      return false;
    } else {
      setSigninPasswordErrorMessage(null);
      return true;
    }
  }

  bool signinCheck(String email, String password) {
    bool isEmailValid = validateEmail(email);
    bool isPasswordValid = validatePassword(password);
    if (isEmailValid && isPasswordValid) {
      signin(email, password);
      return true;
    } else {
      return false;
    }
  }

}