import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:event_sg/repositories/repositories.dart';
import 'package:event_sg/models/models.dart';
import 'package:event_sg/blocs/blocs.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;
  
  NotificationBloc({@required this.notificationRepository}) : assert(notificationRepository != null);
  
  @override
  NotificationState get initialState => NotificationEmpty();
  
  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is GetNotificationList) {
      try {
        final List<NotificationDefined> notifications = await notificationRepository.getNotificationList(event.userId);
        yield NotificationLoaded(notifications: notifications);
      } catch(_) {
        yield NotificationError();
      }
    }

    if (event is Refresh) {
      try {
        final List<NotificationDefined> notifications = await notificationRepository.getNotificationList(event.userId);
        yield NotificationLoaded(notifications: notifications);
      } catch(_) {
        yield state;
      }
    }
  }
}