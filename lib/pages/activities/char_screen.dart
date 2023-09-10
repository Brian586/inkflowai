import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';
import 'package:inkflowai/widgets/camera_button.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import '../../main.dart';
import '../../models/activity.dart';
import '../../widgets/bndbox.dart';
import '../../widgets/camera.dart';
import '../../widgets/progress_widget.dart';

class CharactersScreen extends StatefulWidget {
  final String activityID;
  const CharactersScreen({super.key, required this.activityID});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  bool loading = false;
  bool isActive = false;
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;

  @override
  void initState() {
    super.initState();

    loading = true;

    loadModel().then((val) {
      setState(() {
        loading = false;
      });
    });
  }

  Future loadModel() async {
    Tflite.close();
    try {
      Activity activity = activities
          .where((act) => act.activityID == widget.activityID)
          .toList()
          .first;

      String? res = await Tflite.loadModel(
        model: activity.model!,
        labels: activity.labels!,
      );

      print("====================");

      print(res);
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  Widget _buildBody(Size size) {
    if (!isActive) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CameraButton(
            activityID: widget.activityID,
            onTap: () => setState(() => isActive = true),
          )
        ],
      );
    }

    return Stack(
      children: [
        Camera(
          cameras,
          setRecognitions,
        ),
        BndBox(
          _recognitions,
          math.max(_imageHeight, _imageWidth),
          math.min(_imageHeight, _imageWidth),
          size.height,
          size.width,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AdaptiveUI(
      appbarTitle: "Identify Characters",
      body: loading ? circularProgress() : _buildBody(size),
      actions: [
        isActive
            ? IconButton(
                onPressed: () => setState(() => isActive = false),
                icon: Icon(Icons.videocam_off_outlined),
              )
            : const SizedBox()
      ],
      isScrollable: false,
    );
  }
}
