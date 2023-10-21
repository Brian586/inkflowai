import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';

class TestOpenCV extends StatefulWidget {
  const TestOpenCV({super.key});

  @override
  State<TestOpenCV> createState() => _TestOpenCVState();
}

class _TestOpenCVState extends State<TestOpenCV> {
  List<Uint8List> imageBytes = [];
  String imagePath = "assets/models/lena.jpg";

  List<double> kernelSize = [7.0, 7.0];

  @override
  void initState() {
    super.initState();

    processImage();
  }

  void processImage() async {
    Uint8List? imgGray = await Cv2.cvtColor(
        pathFrom: CVPathFrom.ASSETS,
        pathString: imagePath,
        outputType: Cv2.COLOR_BGR2GRAY);

    Uint8List? imgBlur = await Cv2.gaussianBlur(
        pathFrom: CVPathFrom.ASSETS,
        pathString: imagePath,
        kernelSize: kernelSize,
        sigmaX: 0);

    Uint8List? imgDilation = await Cv2.dilate(
        pathFrom: CVPathFrom.ASSETS,
        pathString: imagePath,
        kernelSize: kernelSize);

    Uint8List? imgEroded = await Cv2.erode(
        pathFrom: CVPathFrom.ASSETS,
        pathString: imagePath,
        kernelSize: kernelSize);

    List<Uint8List> _bytes = [imgGray!, imgBlur!, imgDilation!, imgEroded!];

    setState(() {
      imageBytes.addAll(_bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(imageBytes.length, (index) {
        return Image.memory(
          imageBytes[index],
          height: 300.0,
          width: size.width,
          fit: BoxFit.contain,
        );
      }),
    );
  }
}
