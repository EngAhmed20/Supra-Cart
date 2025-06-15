import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  SupabaseClient client= Supabase.instance.client;
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
}
