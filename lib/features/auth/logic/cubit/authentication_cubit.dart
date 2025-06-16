import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial()){
    init();}
  SupabaseClient client= Supabase.instance.client;
  late bool hidePass;
  late TextEditingController loginEmailController;
  late TextEditingController loginPasswordController;
  late GlobalKey<FormState>loginFormKey;
 late AutovalidateMode autovalidateMode;
  init(){
    hidePass = true;
    loginEmailController = TextEditingController();
    loginPasswordController = TextEditingController();
    loginFormKey = GlobalKey<FormState>();
    autovalidateMode = AutovalidateMode.disabled;
    emit(AuthenticationInitial());

  }
  dispose() {

    emit(AuthenticationDisposed());
  }

  changePasswordVisibility() {
    hidePass = !hidePass;
    emit(AuthenticationPasswordVisibilityChanged());
  }
  ////////////////////////////
  /// login
  Future<void> loginUser({required String email, required String password}) async {
    emit(AuthenticationLoginLoading());
    try {
      await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      emit(AuthenticationLoginSuccess());

    } on AuthException catch(e){
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
}
