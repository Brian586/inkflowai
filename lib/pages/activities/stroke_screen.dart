import 'package:flutter/material.dart';
import 'package:inkflowai/pages/webview_stack.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';
import '../../models/activity.dart';
import '../../widgets/camera_button.dart';
import '../../widgets/progress_widget.dart';

class StrokeScreen extends StatefulWidget {
  final String activityID;
  const StrokeScreen({super.key, required this.activityID});

  @override
  State<StrokeScreen> createState() => _StrokeScreenState();
}

class _StrokeScreenState extends State<StrokeScreen> {
  bool loading = false;
  bool isActive = false;
  // List<dynamic> _recognitions = [];
  // int _imageHeight = 0;
  // int _imageWidth = 0;

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

    Activity activity = activities
        .where((activity) => activity.activityID == widget.activityID)
        .toList()
        .first;
    int red = activity.rgbColor![0];
    int green = activity.rgbColor![1];
    int blue = activity.rgbColor![2];

    Color color = Color.fromRGBO(red, green, blue, 1.0);

    return WebViewStack(
      url: activity.model!,
      color: color,
    );

    // return Stack(
    //   children: [
    //     Camera(
    //       cameras,
    //       setRecognitions,
    //     ),
    //     BndBox(
    //       _recognitions,
    //       math.max(_imageHeight, _imageWidth),
    //       math.min(_imageHeight, _imageWidth),
    //       size.height,
    //       size.width,
    //     ),
    //   ],
    // );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AdaptiveUI(
      appbarTitle: "Stroke",
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
