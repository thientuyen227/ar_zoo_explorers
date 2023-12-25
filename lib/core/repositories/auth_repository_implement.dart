import 'dart:io';

import 'package:ar_zoo_explorers/core/data/models/user_model.dart';
import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_auth_source.dart';
import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/user_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internationalization/internationalization.dart';

class AuthRepositoryImplement implements AuthRepository {
  final FirebaseAuthSource _firebaseAuth = FirebaseAuthSource();
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();

  Future<UserModel> getUserOrCreateUser(UserCredential userCredential,
      {String? fullname,
      String? phone,
      String? address,
      String? birth,
      String? gender,
      String? role,
      bool? status}) async {
    UserModel? user = await _firestoreSource.getUser(userCredential.user!.uid);
    if (user != null) {
      Timestamp timestamp = Timestamp.now();
      DateTime dateTime = timestamp.toDate();
      String key = DateFormat('dd-MM-yyyy').format(dateTime);

      CollectionReference<Map<String, dynamic>> loginHistory = FirebaseFirestore
          .instance
          .collection('user')
          .doc(user.id)
          .collection('login_histories');

      loginHistory.doc(key).get().then((value) async {
        if (!value.exists) {
          await loginHistory.doc(key).set({'archieveAt': timestamp});
        }
      });
      return user;
    } else {
      return await _firestoreSource.createUser(UserModel.fromUserCredential(
          userCredential,
          fullname: fullname,
          phone: phone,
          address: address,
          birth: birth,
          gender: 'male',
          role: 'customer',
          status: true));
    }
  }

  @override
  Future<Either<Failure, Success<UserEntity>>> login(
      {required String email, required String password}) {
    return ResponseHandler.processResponse(() async {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel user = await getUserOrCreateUser(userCredential);

      return Success(data: user, message: "Login successful");
    });
  }

  @override
  Future<Either<Failure, Success<UserEntity>>> loginWithGoogle() {
    return ResponseHandler.processResponse(() async {
      var userCredential = await _firebaseAuth.signInWithGoogle();

      UserModel user = await getUserOrCreateUser(userCredential);
      return Success(data: user, message: "Login successful");
    });
  }

  @override
  Future<Either<Failure, Success<UserEntity>>> loginWithFacebook() {
    return ResponseHandler.processResponse(() async {
      var userCredential = await _firebaseAuth.signInWithFacebook();

      UserModel user = await getUserOrCreateUser(userCredential);
      return Success(data: user, message: "Login successful");
    });
  }

  @override
  Future<Either<Failure, Success<UserEntity>>> signUp({
    required String fullname,
    required String email,
    required String password,
  }) {
    return ResponseHandler.processResponse(() async {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel user =
          await getUserOrCreateUser(userCredential, fullname: fullname);
      return Success(data: user, message: "Sign up successful");
    });
  }

  @override
  Future<Either<Failure, Success>> logout() {
    return ResponseHandler.processResponse(() async {
      return Success(data: _firebaseAuth.logout());
    });
  }

  @override
  Future<Either<Failure, Success<UserEntity>>> getUserProfileById(String uid) {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.getUser(uid) ??
            UserEntity(
                id: '',
                avatarUrl: '',
                fullname: '',
                email: '',
                provider: '',
                phone: '',
                address: '',
                birth: '',
                gender: '',
                role: '',
                status: true),
      );
    });
  }

  @override
  Future<Either<Failure, Success>> sendPasswordResetEmail(String email) {
    return ResponseHandler.processResponse(() async {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Success(
          data: Fluttertoast.showToast(msg: "Send email successful!"));
    });
  }

  @override
  Future<Either<Failure, Success<UserEntity>>> updateUserProfile(
      {required String id,
      required String fullname,
      required String phone,
      required String avatarUrl,
      required String address,
      required String birth,
      required String provider,
      required String gender,
      required String role,
      required bool status}) {
    return ResponseHandler.processResponse(() async {
      return Success(
        data: await _firestoreSource.updateUser(
                id: id,
                fullname: fullname,
                phone: phone,
                avatarUrl: avatarUrl,
                address: address,
                birth: birth,
                provider: provider,
                gender: gender,
                role: role,
                status: status) ??
            UserEntity(
                id: '',
                avatarUrl: '',
                fullname: '',
                email: '',
                provider: '',
                phone: '',
                address: '',
                birth: '',
                gender: '',
                role: '',
                status: true),
      );
    });
  }

  @override
  Future<Either<Failure, Success>> changePassword(
      String oldPassword, String newPassword) {
    return ResponseHandler.processResponse(() async {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      return Success(
          data: Fluttertoast.showToast(msg: "Change password successful!"));
    });
  }

  @override
  Future<Either<Failure, Success<String>>> uploadImageToFirebase(
      String imagePath, String imageName) async {
    return ResponseHandler.processResponse(() async {
      File imageFile = File(imagePath);
      String storagePath = 'user_images/$imageName';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(storagePath);
      await storageReference.putFile(imageFile);
      String downloadURL = await storageReference.getDownloadURL();
      downloadURL ??= "";
      return Success(data: downloadURL);
    });
  }
}
