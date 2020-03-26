import 'dart:async';
import 'package:bloc/bloc.dart';
import './blocs.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  @override
  RegistrationState get initialState => InitialRegistrationState();

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
