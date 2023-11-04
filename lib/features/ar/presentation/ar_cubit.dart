import 'dart:io';

// import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_anchor.dart';
// import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class ARCubit extends BaseCubit<ARState> {
  ARCubit() : super(ARState());

  String? valueName;
  FirebaseStorage storage = FirebaseStorage.instance;

  // ARSessionManager? arSessionManager;
  // ARObjectManager? arObjectManager;
  // ARAnchorManager? arAnchorManager;

  bool? downloaded = false;

  HttpClient? httpClient;
  // List<ARNode> nodes = [];
  // List<ARAnchor> anchors = [];

  Future<Map<String, dynamic>> getFilePath(String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename.glb');
    return {'dir': dir, 'file': file};
  }

  void downloadAndUnpack(String id, String url, String filename) async {
    Map<String, dynamic> filePathInfo = await getFilePath(filename);
    String dir = filePathInfo['dir'];
    File file = filePathInfo['file'];
    bool filePath = await checkFileExits(file.path);
    //get link download
    String modelUrl = await storage
        .ref()
        .child("animal_models/" '$filename' ".zip")
        .getDownloadURL();
    Fluttertoast.showToast(msg: modelUrl);
    if (!filePath) {
      var request = await httpClient!.getUrl(Uri.parse(modelUrl));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      await file.writeAsBytes(bytes);
      Fluttertoast.showToast(msg: "Down" '$file');
      try {
        await ZipFile.extractToDirectory(
            zipFile: file, destinationDir: Directory(dir));
        Fluttertoast.showToast(msg: "giải nén thành công");
        print("Unzipping successful");
      } catch (e) {
        Fluttertoast.showToast(msg: "giải nén thất bại: " '$e');
        print("Unzipping failed: $e");
      }
    }
  }

  // void onARViewCreated(
  //   ARSessionManager arSessionManager,
  //   ARObjectManager arObjectManager,
  //   ARAnchorManager arAnchorManager,
  //   ARLocationManager arLocationManager,
  // ) {
  //   this.arSessionManager = arSessionManager;
  //   this.arObjectManager = arObjectManager;
  //   this.arAnchorManager = arAnchorManager;

  //   this.arSessionManager!.onInitialize(
  //         showFeaturePoints: false,
  //         showPlanes: true,
  //         customPlaneTexturePath: "Images/triangle.png",
  //         showWorldOrigin: true,
  //         handlePans: true,
  //         handleRotation: true,
  //       );
  //   this.arObjectManager!.onInitialize();
  //   httpClient = HttpClient();

  //   this.arSessionManager!.onPlaneOrPointTap = (hitTestResults) {
  //     onPlaneOrPointTapped(hitTestResults, valueName.toString());
  //   };
  //   this.arObjectManager!.onPanStart = onPanStarted;
  //   this.arObjectManager!.onPanChange = onPanChanged;
  //   this.arObjectManager!.onPanEnd = onPanEnded;
  //   this.arObjectManager!.onRotationStart = onRotationStarted;
  //   this.arObjectManager!.onRotationChange = onRotationChanged;
  //   this.arObjectManager!.onRotationEnd = onRotationEnded;
  // }

  // Future<void> onRemoveEverything() async {
  //   /*nodes.forEach((node) {
  //     this.arObjectManager.removeNode(node);
  //   });*/
  //   for (var anchor in anchors) {
  //     arAnchorManager!.removeAnchor(anchor);
  //   }
  //   anchors = [];
  // }

  // Future<void> onPlaneOrPointTapped(
  //     List<ARHitTestResult> hitTestResults, String name) async {
  //   // Bước 1: Tìm một kết quả hit test loại mặt phẳng đầu tiên.
  //   var singleHitTestResult = hitTestResults.firstWhere(
  //       (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);

  //   // Bước 2: Tạo một mặt phẳng AR mới dựa trên kết quả hit test.

  //   var newAnchor =
  //       ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
  //   // Bước 3: Thử thêm mặt phẳng AR mới vào quản lý anchor.
  //   bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
  //   // Bước 4: Kiểm tra xem việc thêm anchor đã thành công hay không.
  //   if (didAddAnchor!) {
  //     // Bước 5: Nếu thành công, thêm mặt phẳng vào danh sách.

  //     anchors.add(newAnchor);
  //     // Bước 6: Tạo một đối tượng ARNode mới để đại diện cho đối tượng 3D.
  //     var newNode = ARNode(
  //         type: NodeType.fileSystemAppFolderGLB,
  //         uri: '$name/' 'source/' '$name' ".glb",
  //         scale: Vector3(0.2, 0.2, 0.2),
  //         position: Vector3(0.0, 0.0, 0.0),
  //         rotation: Vector4(1.0, 0.0, 0.0, 0.0));

  //     // Bước 7: Thử thêm đối tượng ARNode vào mặt phẳng AR.
  //     bool? didAddNodeToAnchor =
  //         await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);

  //     // Bước 8: Kiểm tra xem việc thêm node vào anchor đã thành công hay không.
  //     if (didAddNodeToAnchor!) {
  //       // Bước 9: Nếu thành công, thêm đối tượng ARNode vào danh sách.
  //       nodes.add(newNode);
  //       Fluttertoast.showToast(msg: "Thêm thành công");
  //     } else {
  //       // Xử lý lỗi nếu việc thêm node vào anchor thất bại.
  //       arSessionManager!.onError("Adding Node to Anchor failed");
  //     }
  //   } else {
  //     // Xử lý lỗi nếu việc thêm anchor thất bại.
  //     arSessionManager!.onError("Adding Anchor failed");
  //   }
  // }

  // onPanStarted(String nodeName) {
  //   print("Started panning node $nodeName");
  // }

  // onPanChanged(String nodeName) {
  //   print("Continued panning node $nodeName");
  // }

  // onPanEnded(String nodeName, Matrix4 newTransform) {
  //   print("Ended panning node $nodeName");
  //   final pannedNode = nodes.firstWhere((element) => element.name == nodeName);

  //   /*
  //   * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
  //   * (e.g. if you intend to share the nodes through the cloud)
  //   */
  //   //pannedNode.transform = newTransform;
  // }

  // onRotationStarted(String nodeName) {
  //   print("Started rotating node $nodeName");
  // }

  // onRotationChanged(String nodeName) {
  //   print("Continued rotating node $nodeName");
  // }

  // onRotationEnded(String nodeName, Matrix4 newTransform) {
  //   print("Ended rotating node $nodeName");
  //   final rotatedNode = nodes.firstWhere((element) => element.name == nodeName);

  //   /*
  //   * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
  //   * (e.g. if you intend to share the nodes through the cloud)
  //   */
  //   //rotatedNode.transform = newTransform;
  // }

  Future<bool> checkFileExits(String name) async {
    return File(name).exists();
  }

  Future<bool> downloadModel(String name) async {
    Map<String, dynamic> filePathInfo = await getFilePath(name);
    File file = filePathInfo['file'];
    bool fileExits = await checkFileExits(file.path);
    if (fileExits) {
      return true;
    }
    return false;
  }
}
