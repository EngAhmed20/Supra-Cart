import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart/core/utilis/constants.dart';
import 'package:supra_cart/core/utilis/user_model.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.client, this.sharedPreferences) : super(AuthenticationInitial()) {
    init();
  }

  SupabaseClient client;
  late bool hidePass;
  late bool hideConfirmPass;
  late TextEditingController loginEmailController;
  late TextEditingController loginPasswordController;
  late GlobalKey<FormState>loginFormKey;
  late TextEditingController registerNameController;
  late TextEditingController registerEmailController;
  late TextEditingController registerPasswordController;
  late TextEditingController registerConfirmPasswordController;
  late GlobalKey<FormState>registerFormKey;
  late AutovalidateMode autovalidateMode, signUpAutovalidateMode,
      resetPassAutovalidateMode;
  late GlobalKey<FormState>resetPassFormKey;
  late TextEditingController resetPassEmailController;
  final SharedPreferences sharedPreferences;

  init() {
    hidePass = true;
    hideConfirmPass = true;
    loginEmailController = TextEditingController();
    loginPasswordController = TextEditingController();
    loginFormKey = GlobalKey<FormState>();
    registerFormKey = GlobalKey<FormState>();
    registerNameController = TextEditingController();
    registerEmailController = TextEditingController();
    registerPasswordController = TextEditingController();
    registerConfirmPasswordController = TextEditingController();
    autovalidateMode = AutovalidateMode.disabled;
    resetPassFormKey = GlobalKey<FormState>();
    resetPassEmailController = TextEditingController();
    signUpAutovalidateMode = AutovalidateMode.disabled;
    resetPassAutovalidateMode = AutovalidateMode.disabled;
    emit(AuthenticationInitial());
  }

  dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    hidePass = true;
    hideConfirmPass = true;

    emit(AuthenticationDisposed());
  }

  changePasswordVisibility() {
    hidePass = !hidePass;
    emit(AuthenticationPasswordVisibilityChanged());
  }

  changeConfirmPasswordVisibility() {
    hideConfirmPass = !hideConfirmPass;
    emit(AuthenticationPasswordVisibilityChanged());
  }

  ////////////////////////////
  /// login
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(AuthenticationLoginLoading());
    try {
      await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      clearTextFiled();
      await getUserData();
      emit(AuthenticationLoginSuccess());
    } on AuthException catch (e) {
      emit(AuthenticationLoginFailure(e.message));
    }
    catch (e) {
      emit(AuthenticationLoginFailure(e.toString()));
    }
  }

  // login button pressed
  void loginButtonPressed() {
    if (loginFormKey.currentState!.validate()) {
      autovalidateMode = AutovalidateMode.disabled;
      loginUser(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text.trim(),
      );
    } else {
      autovalidateMode = AutovalidateMode.always;
      emit(AuthenticationLoginValidationError());
    }
  }

  /// login with google
  GoogleSignInAccount ?googleUser;

  Future<AuthResponse> googleSignIn() async {
    emit(AuthenticationGoogleSignInLoading());
    const webClientId = '98169094910-hgqhr09etdjahfnp31ujqnsgpvkf9a9u.apps.googleusercontent.com';


    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return AuthResponse();
    }
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      emit(AuthenticationGoogleSignInFailure('No Access Token found.'));
      return AuthResponse();
    }
    if (idToken == null) {
      emit(AuthenticationGoogleSignInFailure('No ID Token found.'));
      return AuthResponse();
    }

    AuthResponse response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    //check if user exists in the database
    final userId = client.auth.currentUser!.id;
    final userExists = await isUserAlreadyExists(userId);
    if (!userExists) {
      // If user does not exist, add user data
      await addUserData(
          name: googleUser!.displayName!, email: googleUser!.email);
      await getUserData();
      emit(AuthenticationGoogleSignInSuccess());
      return response;
    }
    await getUserData();
    emit(AuthenticationGoogleSignInSuccess());

    return response;
  }

  ///////////////////////////////////////////////////////register
  /// register function
  Future <void> registerUser(
      {required String name, required String email, required String password}) async {
    try {
      emit(AuthenticationRegisterLoading());
      await client.auth.signUp(password: password, email: email);
      try {
        await addUserData(name: name, email: email);
        await getUserData();
        clearTextFiled();
        emit(AuthenticationRegisterSuccess());
      } catch (e) {
        await logout();
        emit(AuthenticationRegisterFailure(
            "Signed up but failed to save user data. Please try again."));
      }
    } on AuthException catch (e) {
      emit(AuthenticationRegisterFailure(e.message));
    }
    catch (e) {
      emit(AuthenticationRegisterFailure(e.toString()));
    }
  }

// register button pressed
  void registerButtonPressed() {
    if (registerFormKey.currentState!.validate()) {
      registerUser(
        name: registerNameController.text.trim(),
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text.trim(),
      );
      signUpAutovalidateMode = AutovalidateMode.disabled;
    } else {
      signUpAutovalidateMode = AutovalidateMode.always;
      emit(AuthenticationRegisterValidationError());
    }
  }

  /// reset pass
  Future<void> resetPassword({required String email}) async {
    emit(AuthenticationPasswordResetLoading());
    try {
      await client.auth.resend(type: OtpType.signup,
          email: email
      );
      emit(AuthenticationPasswordResetSuccess());
    } catch (e) {
      emit(AuthenticationPasswordResetFailure(e.toString()));
    }
  }

  resetPasswordButtonPressed() {
    if (resetPassFormKey.currentState!.validate()) {
      resetPassword(
        email: resetPassEmailController.text.trim(),
      );
    } else {
      resetPassAutovalidateMode = AutovalidateMode.always;
      emit(AuthenticationPasswordResetValidationError());
    }
  }

  /// logout
  Future<void> logout() async {
    try {
      emit(AuthenticationLogoutLoading());
      await client.auth.signOut();
      await sharedPreferences.remove(userData);
      emit(AuthenticationLogoutSuccess());
    } catch (e) {
      emit(AuthenticationLogoutFailure(e.toString()));
    }
  }

////////////////////// add user data
  Future<void> addUserData(
      {required String name, required String email}) async {
    emit(AuthenticationAddUserDataLoading());
    try {
      await client.from(userTable).insert({
        'id': client.auth.currentUser!.id,
        'name': name,
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
      });
      emit(AuthenticationAddUserDataSuccess());
    } catch (e) {
      emit(AuthenticationAddUserDataFailure(e.toString()));
      rethrow;
    }
  }

  void clearTextFiled() {
    loginEmailController.clear();
    loginPasswordController.clear();
    registerNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    resetPassEmailController.clear();
  }

  Future<bool> isUserAlreadyExists(String userId) async {
    try {
      await client.from(userTable).select().eq('id', userId).maybeSingle();
      return true;
    } catch (e) {
      return false;
    }
  }
UserModel ? userModel;
  Future<void> getUserData() async {
    emit(AuthenticationGetUserDataLoading());
    try {
      final response = await client.from(userTable).select().eq('id', client.auth.currentUser!.id).maybeSingle();

      if (response != null) {
        userModel = UserModel.fromJson(response);
        await saveUserDataToPrefs(userModel!);
        log('User data retrieved: ${userModel!.toJson()}');
        emit(AuthenticationGetUserDataSuccess());
      } else {
        emit(AuthenticationGetUserDataFailure('No user data found.'));
      }
    } catch (e) {
      emit(AuthenticationGetUserDataFailure(e.toString()));
    }
  }
UserModel userSavedDataModel= UserModel(
    id: '0',
    name: 'UserName',
    email: 'UserEmail',
  );
  /// save user data to shared preferences
Future<void>saveUserDataToPrefs(UserModel model)async{
    String data=jsonEncode(model.toJson());
    await sharedPreferences.setString(userData, data);
    await getUserDataFromPrefs();
}
  Future<void> getUserDataFromPrefs() async {
    final prefs = await sharedPreferences.getString(userData);
    if (prefs != null) {
      final userData=jsonDecode(prefs);
      userSavedDataModel= UserModel.fromJson(userData);
      emit(AuthenticationUserDataLoaded(userSavedDataModel));
      return;
    }
    userSavedDataModel;
    emit(AuthenticationUserDataNotFound(
        'No user data found in shared preferences.'));
  }
}

