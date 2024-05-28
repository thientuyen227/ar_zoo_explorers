enum MsgType {
  text,
  image,
  sound,
}

extension MsgTypeExtension on MsgType {
  String get typeString {
    switch (this) {
      case MsgType.text:
        return 'text';
      case MsgType.image:
        return 'image';
      case MsgType.sound:
        return 'sound';
      default:
        return '';
    }
  }
}
