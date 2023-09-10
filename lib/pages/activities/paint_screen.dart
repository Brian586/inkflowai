import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';

import '../../main.dart';
import '../../widgets/camera_button.dart';

class PaintScreen extends StatefulWidget {
  final String activityID;
  const PaintScreen({super.key, required this.activityID});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  bool isWorking = false;
  late CameraController cameraController;
  late CameraImage cameraImage;
  String result = "";

  void initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  cameraImage = imageFromStream,
                }
            });
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    if (!cameraController.value.isInitialized) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CameraButton(
            activityID: widget.activityID,
            onTap: () => initCamera(),
          )
        ],
      );
    }
    return MaterialApp(
      home: CameraPreview(cameraController),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveUI(
      appbarTitle: "Colour Images",
      body: _buildBody(),
      actions: [],
      isScrollable: false,
    );
  }
}
