part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}
class AuthenticationDisposed extends AuthenticationState {}
class AuthenticationPasswordVisibilityChanged extends AuthenticationState {}
class AuthenticationLoginValidationError extends AuthenticationState {}
class AuthenticationRegisterValidationError extends AuthenticationState {}
class AuthenticationLoading extends AuthenticationState {}
class AuthenticationLoginLoading extends AuthenticationState {}
class AuthenticationLoginSuccess extends AuthenticationState {

}
class AuthenticationLoginFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationLoginFailure(this.errorMessage);
}
class AuthenticationRegisterLoading extends AuthenticationState {}
class AuthenticationRegisterSuccess extends AuthenticationState {

}
class AuthenticationRegisterFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationRegisterFailure(this.errorMessage);
}
class AuthenticationGoogleSignInLoading extends AuthenticationState {}
class AuthenticationGoogleSignInSuccess extends AuthenticationState {}
class AuthenticationGoogleSignInFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationGoogleSignInFailure(this.errorMessage);
}
class AuthenticationLogoutLoading extends AuthenticationState {}
class AuthenticationLogoutSuccess extends AuthenticationState {}
class AuthenticationLogoutFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationLogoutFailure(this.errorMessage);
}
class AuthenticationPasswordResetLoading extends AuthenticationState {}
class AuthenticationPasswordResetSuccess extends AuthenticationState {}
class AuthenticationPasswordResetFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationPasswordResetFailure(this.errorMessage);
}
class AuthenticationPasswordResetValidationError extends AuthenticationState {}
class AuthenticationAddUserDataLoading extends AuthenticationState {}
class AuthenticationAddUserDataSuccess extends AuthenticationState {}
class AuthenticationAddUserDataFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationAddUserDataFailure(this.errorMessage);
}
class  AuthenticationGetUserDataLoading extends AuthenticationState {}
class AuthenticationGetUserDataSuccess extends AuthenticationState {

}
class AuthenticationGetUserDataFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationGetUserDataFailure(this.errorMessage);
}
class AuthenticationUserDataLoaded extends AuthenticationState {
  final UserModel user;

  AuthenticationUserDataLoaded(this.user);
}
class AuthenticationUserDataNotFound extends AuthenticationState {
  final String errorMessage;

  AuthenticationUserDataNotFound(this.errorMessage);
}