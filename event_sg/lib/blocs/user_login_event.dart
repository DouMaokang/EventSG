import 'package:meta/meta.dart';

@immutable
abstract class UserLoginEvent {}

class UserLoginClicked extends UserLoginEvent {
  final String email;
  final String password;

  UserLoginClicked({@required this.email, @required this.password});
}
