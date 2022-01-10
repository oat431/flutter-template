import 'package:flutter_template/notifications/message.dart';
import 'package:flutter_template/notifications/notifications_manager.dart';

/// Parses remote notification data to a [Message] or a subtype.
///
/// Extend this class to implement message parsing specific to your remote data.
/// Register a message parser in [NotificationsManager].
abstract class MessageParser {
  Message parseMessage(dynamic remoteData);
}

/// Message parser that will use a separate parser for each message type.
abstract class MultiMessageParser implements MessageParser {
  final Map<String, MessageParser> _messageParserForType = Map();

  /// Registers a [MessageParser] for a specific [Message.type]
  void registerMessageParser({
    required MessageParser parser,
    required Iterable<String> forMessageTypes,
  }) {
    forMessageTypes.forEach((type) {
      _messageParserForType[type] = parser;
    });
  }

  /// Determines the [Message.type] from raw remote notification data.
  String getTypeFromRawMessage(dynamic remoteData);

  @override
  Message parseMessage(remoteData) {
    final type = getTypeFromRawMessage(remoteData);
    final parser = _messageParserForType[type];
    if (parser == null) {
      throw Exception('NotificationsManager - '
          'Message type does not have a parser: $type');
    }
    return parser.parseMessage(remoteData);
  }
}

/// Message parser that expects a [Message] as param and just forwards it.
class StubMessageParser implements MessageParser {
  @override
  Message parseMessage(remoteData) => remoteData as Message;
}