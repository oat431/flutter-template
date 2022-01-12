import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_template/notifications/message.dart';
import 'package:flutter_template/notifications/message_parser.dart';

class FcmRemoteMessageParser extends MultiMessageParser {
  @override
  String getTypeFromRawMessage(dynamic remoteData) =>
      (remoteData as RemoteMessage).messageType!;

  @override
  Message onUnknownType(String? type, dynamic remoteData) =>
      FcmBaseMessage(remoteData);
}

class FcmBaseMessage extends Message {
  final RemoteMessage remoteMessage;

  FcmBaseMessage(this.remoteMessage) : super(remoteMessage.messageType!);

  @override
  String toString() {
    return 'FcmBaseMessage{'
        'type: $type'
        'remoteMessage: ${remoteMessage.print()}'
        '}';
  }
}

extension RemoteMessageUtil on RemoteMessage {
  String print() {
    return 'RemoteMessage{'
        'senderId: $senderId, '
        'category: $category, '
        'collapseKey: $collapseKey, '
        'contentAvailable: $contentAvailable, '
        'data: $data, '
        'from: $from, '
        'messageId: $messageId, '
        'messageType: $messageType, '
        'mutableContent: $mutableContent, '
        'notification: $notification, '
        'sentTime: $sentTime, '
        'threadId: $threadId, '
        'ttl: $ttl'
        '}';
  }
}
