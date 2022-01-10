import 'package:flutter_template/notifications/message.dart';
import 'package:flutter_template/notifications/message_handler.dart';
import 'package:flutter_template/notifications/notifications_manager.dart';

/// Filters a remote [Message] to not be handled by [MessageHandler].
///
/// Register a global message filter in [NotificationsManager].
abstract class MessageFilter {
  /// Return false to discard the message, true otherwise.
  Future<bool> filterMessage(Message message);
}

/// Handles the notification only if there is a logged in user.
class LoggedInUserOnlyFilter implements MessageFilter {
  late final Future<bool> Function() isUserLoggedIn;

  @override
  Future<bool> filterMessage(Message _) => isUserLoggedIn();
}

/// You shall not pass filter.
class DiscardAllFilter implements MessageFilter {
  @override
  Future<bool> filterMessage(Message _) async => false;
}