enum MsgType {
  text,
  image_asset,
  image_file,
  image_network,
  sound,
}

extension MsgTypeExtension on MsgType {
  String get typeString {
    switch (this) {
      case MsgType.text:
        return 'text';
      case MsgType.image_asset:
        return 'image_asset';
      case MsgType.image_file:
        return 'image_file';
      case MsgType.image_network:
        return 'image_network';
      case MsgType.sound:
        return 'sound';
      default:
        return '';
    }
  }
}
