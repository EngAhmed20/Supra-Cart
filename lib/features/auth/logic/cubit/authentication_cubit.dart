import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.client) : super(AuthenticationInitial()){
    init();}
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
 late AutovalidateMode autovalidateMode;
  init(){
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
    emit(AuthenticationInitial());

  }
  dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    loginFormKey.currentState?.dispose();
    registerFormKey.currentState?.dispose();
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
  ///////////////////////////////////////////////////////register
/// register function
Future <void> registerUser({required String name,required String email,required String password})async {
    try{
      emit(AuthenticationRegisterLoading());
      await client.auth.signUp(password: password,email: email);
      emit(AuthenticationRegisterSuccess());

    }on AuthException catch(e){
      emit(AuthenticationRegisterFailure(e.message));}
    catch(e){
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
    } else {
      autovalidateMode = AutovalidateMode.always;
      emit(AuthenticationRegisterValidationError());
    }
  }

}
