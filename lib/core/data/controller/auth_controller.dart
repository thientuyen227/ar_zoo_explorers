import 'package:ar_zoo_explorers/app/config/app_router.gr.dart';
import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/core/data/models/user_model.dart';
import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/helpers/notification_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/auth_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/user_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/user_repository.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthController extends ControllerHelper {
  final AuthRepository _authRepository = AuthRepositoryImplement();

  Rx<Future?> loginFuture = Rx(null);
  Rx<Future?> signUpFuture = Rx(null);

  Rx<UserEntity> currentUser = Rx(UserModel(
      id: '',
      email: '',
      fullname: '',
      phone: '',
      avatarUrl: '',
      address: '',
      birth: '',
      provider: ''));

  signUp(
      {required String fullname,
      required String email,
      required String password,
      required bool fromOnboard}) async {
    return signUpFuture.value = processRequest<UserEntity>(
        request: () => _authRepository.signUp(
              fullname: fullname,
              email: email,
              password: password,
            ),
        onFailure: (failure) =>
            NotificationHelper.showSnackBar(message: failure.message),
        onSuccess: (success) => {
              if (fromOnboard) {Get.back()} else {Get.offNamed(Routes.login)},
              NotificationHelper.showSnackBar(message: success.message)
            });
  }

  Future<void> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    loginFuture.value = processRequest<UserEntity>(
        request: () => _authRepository.login(email: email, password: password),
        onFailure: (failure) => NotificationHelper.showSnackBar(
            message: "Tài khoản hoặc mật khẩu bị sai"),
        onSuccess: (success) => _onLoginSuccess(context, success.data));
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    loginFuture.value = processRequest<UserEntity>(
      request: () => _authRepository.loginWithGoogle(),
      onFailure: (failure) =>
          NotificationHelper.showSnackBar(message: failure.message),
      onSuccess: (success) => _onLoginSuccess(context, success.data),
    );
  }

  checkAuthState(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          context.router.pushAndPopUntil(
            const HomeRoute(),
            predicate: (route) => route.settings.name == '/home',
          );
        } else {
          context.router.replace(const WelcomeRoute());
        }
      } catch (e) {
        context.router.replace(const WelcomeRoute());
      }
    });
  }

  _onLoginSuccess(BuildContext context, UserEntity user) {
    Fluttertoast.showToast(msg: "đăng nhập thành công");
    currentUser.value = user;
    update();
    context.router.replace(const HomeRoute());
  }

  static AuthController get findOrInitialize {
    try {
      return Get.find<AuthController>();
    } catch (e) {
      return Get.put(AuthController(), permanent: true);
    }
  }
}

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    AuthController.findOrInitialize;
  }
}
