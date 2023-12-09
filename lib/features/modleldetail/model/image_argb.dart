import 'package:image/image.dart' as img;

class ARGBImage {
  ARGBImage();

  List<img.Pixel> components = [];

  double weightSum() {
    double weight = 0;
    if (components.isNotEmpty) {
      for (int i = 0; i < components.length; i++) {
        weight = weight + components[i].a;
      }
    }
    return weight;
  }

  num percentage(num alpha, num weightSum) {
    if (weightSum > 0) {
      return alpha / weightSum;
    } else {
      return 0;
    }
  }

  int blendedRed() {
    int blender = 0;
    if (components.isNotEmpty) {
      for (int i = 0; i < components.length; i++) {
        blender = blender +
            (components[i].r * percentage(components[i].r, weightSum()))
                .round();
      }
    }
    return blender;
  }

  int blendedGreen() {
    int blender = 0;
    if (components.isNotEmpty) {
      for (int i = 0; i < components.length; i++) {
        blender = blender +
            (components[i].g * percentage(components[i].g, weightSum()))
                .round();
      }
    }
    return blender;
  }

  int blendedBlue() {
    int blender = 0;
    if (components.isNotEmpty) {
      for (int i = 0; i < components.length; i++) {
        blender = blender +
            (components[i].b * percentage(components[i].b, weightSum()))
                .round();
      }
    }
    return blender;
  }

  void add(img.Pixel color) {
    components.add(color);
  }
}
