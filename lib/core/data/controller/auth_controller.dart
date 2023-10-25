import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/core/data/models/user_model.dart';
import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/helpers/notification_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/auth_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/user_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> login({required String email, required String password}) async {
    loginFuture.value = processRequest<UserEntity>(
        request: () => _authRepository.login(email: email, password: password),
        onFailure: (failure) =>
            NotificationHelper.showSnackBar(message: failure.message),
        onSuccess: (success) => _onLoginSuccess(success.data));
  }

  Future<void> loginWithGoogle() async {
    loginFuture.value = processRequest<UserEntity>(
      request: () => _authRepository.loginWithGoogle(),
      onFailure: (failure) =>
          NotificationHelper.showSnackBar(message: failure.message),
      onSuccess: (success) => _onLoginSuccess(success.data),
    );
  }

  chekcAuthState() {
    Future.delayed(const Duration(seconds: 3), () {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          Get.offAllNamed(Routes.home);
        } else {
          Get.offAllNamed(Routes.welcome);
        }
      } catch (e) {
        Get.offAllNamed(Routes.welcome);
      }
    });
  }

  _onLoginSuccess(UserEntity user) {
    currentUser.value = user;
    update();

    Get.offAllNamed(Routes.home);
  }

  @override
  void onInit() {
    super.onInit();
    chekcAuthState();
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
