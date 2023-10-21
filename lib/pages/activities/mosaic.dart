import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';
import 'package:inkflowai/widgets/progress_widget.dart';
// import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import '../../main.dart';
import '../../tflite/recognition.dart';
import '../../tflite/stats.dart';
import '../../widgets/bndbox.dart';
import '../../widgets/box_widget.dart';
import '../../widgets/camera.dart';
import '../../widgets/camera_button.dart';
import '../../widgets/camera_view.dart';

class MosaicScreen extends StatefulWidget {
  final String activityID;
  const MosaicScreen({super.key, required this.activityID});

  @override
  State<MosaicScreen> createState() => _MosaicScreenState();
}

class _MosaicScreenState extends State<MosaicScreen> {
  bool loading = false;
  bool isActive = false;
  // List<dynamic> _recognitions = [];
  // int _imageHeight = 0;
  // int _imageWidth = 0;
  /// Results to draw bounding boxes
  List<Recognition>? results = [];

  /// Realtime stats
  Stats? stats;

  // @override
  // void initState() {
  //   super.initState();

  //   loading = true;

  //   loadModel().then((val) {
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }

  // Future loadModel() async {
  //   Tflite.close();
  //   try {
  //     Activity activity = activities
  //         .where((act) => act.activityID == widget.activityID)
  //         .toList()
  //         .first;

  //     String? res = await Tflite.loadModel(
  //       model: activity.model!,
  //       labels: activity.labels!,
  //     );

  //     print("====================");

  //     print(res);
  //   } on PlatformException {
  //     print('Failed to load model.');
  //   }
  // }

  // setRecognitions(recognitions, imageHeight, imageWidth) {
  //   setState(() {
  //     _recognitions = recognitions;
  //     _imageHeight = imageHeight;
  //     _imageWidth = imageWidth;
  //   });
  // }

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
        // Camera View
        CameraView(resultsCallback, statsCallback),

        // Bounding boxes
        boundingBoxes(results!),
        // Camera(
        //   cameras,
        //   setRecognitions,
        // ),
        // BndBox(
        //   _recognitions,
        //   math.max(_imageHeight, _imageWidth),
        //   math.min(_imageHeight, _imageWidth),
        //   size.height,
        //   size.width,
        // ),
      ],
    );
  }

  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition> results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results
          .map((e) => BoxWidget(
                result: e,
              ))
          .toList(),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results) {
    setState(() {
      this.results = results;
    });
  }

  /// Callback to get inference stats from [CameraView]
  void statsCallback(Stats stats) {
    setState(() {
      this.stats = stats;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AdaptiveUI(
      appbarTitle: "Mosaic",
      body: loading ? circularProgress() : _buildBody(size),
      actions: [
        isActive
            ? IconButton(
                onPressed: () => setState(() => isActive = false),
                icon: Icon(Icons.videocam_off_outlined),
              )
            : SizedBox()
      ],
      isScrollable: false,
    );
  }
}
