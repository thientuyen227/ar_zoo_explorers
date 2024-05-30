import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/converstation_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatAIState {
  final PageStatus pageStatus;
  double height;
  double width;

  ConversationEntity userChat;
  List<MessageEntity> messages;

  ChatAIState({
    this.pageStatus = PageStatus.loading,
    this.height = 0,
    this.width = 0,
    ConversationEntity? userChat,
    this.messages = const [],
  }) : userChat = userChat ??
            ConversationEntity(
              id: '',
              userId: '',
              chatName: '',
              createdAt: Timestamp.now(),
              updatedAt: Timestamp.now(),
              status: true,
            );

  ChatAIState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    ConversationEntity? userChat,
    List<MessageEntity>? messages,
  }) {
    return ChatAIState(
      pageStatus: pageStatus ?? this.pageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
      userChat: userChat ?? this.userChat,
      messages: messages ?? this.messages,
    );
  }

  setAttributes({
    double? height,
    double? width,
    ConversationEntity? userChat,
    List<MessageEntity>? messages,
  }) async {
    this.height = height ?? this.height;
    this.width = width ?? this.width;
    this.userChat = userChat ?? this.userChat;
    this.messages = messages ?? this.messages;
  }
}
