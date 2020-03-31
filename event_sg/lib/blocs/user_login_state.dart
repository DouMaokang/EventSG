import 'package:meta/meta.dart';

@immutable
abstract class UserLoginState {}

class UserNotLoggedIn extends UserLoginState {}

class UserLoginValidated extends UserLoginState {}

class UserLoginProcessing extends UserLoginState {}
