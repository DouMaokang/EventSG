import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:event_sg/repositories/registration_repository.dart';
import 'package:flutter/material.dart';
import './blocs.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository registrationRepository;


  RegistrationBloc({@required this.registrationRepository})
      : assert(registrationRepository != null);


  @override
  RegistrationState get initialState {
    return RegistrationNotMade();
  }

  @override
  Stream<RegistrationState> mapEventToState(
      RegistrationEvent event,
      ) async* {
    if (event is ConfirmRegistration) {
      yield RegistrationProcessing();
      try {
        registrationRepository.registerEvent(event.eventId, event.userId);
        yield RegistrationConfirmed(hasRegistered: true);
      } catch (_) {
        yield RegistrationError();
      }
    } else if (event is CancelRegistration) {
      yield CancellationProcessing();
      try {
        registrationRepository.deregisterEvent(event.eventId, event.userId);
        yield RegistrationNotMade();
      } catch(_) {
        yield RegistrationError();
      }
    } else if (event is EnterWithRegistration) {
      yield RegistrationConfirmed(hasRegistered: true);
    }
  }
}

