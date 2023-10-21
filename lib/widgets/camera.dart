import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:inkflowai/common/request_assistant.dart';
import 'package:inkflowai/config.dart';
// import 'package:pytorch_mobile/model.dart';
// import 'package:tflite/tflite.dart';
// import 'package:pytorch_mobile/pytorch_mobile.dart';
import 'dart:math' as math;
import 'package:image/image.dart' as img; // Import the image package
import 'package:path_provider/path_provider.dart'; // Import the path_provider package

import 'package:tflite/tflite.dart';

typedef void Callback(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;

  const Camera(this.cameras, this.setRecognitions, {super.key});

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController? controller;
  bool isDetecting = false;

  /// Instance of [Classifier]
  // Classifier classifier;

  /// Instance of [IsolateUtils]
  // IsolateUtils isolateUtils;

  @override
  void initState() {
    super.initState();

    initializeCamera();
  }

  Future initializeCamera() async {
    if (widget.cameras == null || widget.cameras.isEmpty) {
      print('No camera is found');
    } else {
      controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
      );

      // LOAD MODEL
      // Model _imageModel =
      //     await PyTorchMobile.loadModel('assets/models/best.pt');

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller!.startImageStream((CameraImage img) async {
          if (!isDetecting) {
            isDetecting = true;

            int startTime = DateTime.now().millisecondsSinceEpoch;

            // detectFromPytorch(img, _imageModel).then((recognitions) {
            //   int endTime = DateTime.now().millisecondsSinceEpoch;
            //   print("Detection took ${endTime - startTime}");

            //   widget.setRecognitions(recognitions, img.height, img.width);

            //   isDetecting = false;
            // });

            List<dynamic>? recognitions;

            try {
              recognitions = await detectFromAPI(img);
              // recognitions = await Tflite.detectObjectOnFrame(
              //   bytesList: img.planes.map((plane) {
              //     return plane.bytes;
              //   }).toList(),
              //   model: "YOLO",
              //   imageHeight: img.height,
              //   imageWidth: img.width,
              //   imageMean: 0,
              //   imageStd: 255.0,
              //   numResultsPerClass: 1,
              //   threshold: 0.2,
              // );
            } catch (e) {
              print("AN ERROR OCCURRED");
              print(e.toString());
              recognitions = [];
            }

            print("========RECOGNITIONS========");
            print(recognitions);
            print("========RECOGNITIONS========");

            int endTime = new DateTime.now().millisecondsSinceEpoch;
            print("Detection took ${endTime - startTime}");

            // widget.setRecognitions(recognitions!, img.height, img.width);

            isDetecting = false;
          }
        });
      });
    }
  }

  // Future<List<dynamic>> detectFromPytorch(
  //     CameraImage cameraImage, Model _imageModel) async {
  //   // Convert CameraImage to Uint8List
  //   Uint8List imageBytes = convertPyTorchCameraImageToBytes(cameraImage);

  //   // Save the image to a temporary file
  //   File tempFile = await saveImageToTempFile(imageBytes);

  //   print(tempFile.path);

  //   String prediction = await _imageModel.getImagePrediction(tempFile,
  //       cameraImage.width, cameraImage.height, "assets/models/labels.csv");

  //   print(prediction);

  //   return [];
  // }

  Uint8List convertPyTorchCameraImageToBytes(CameraImage image) {
    List<int> bytes = [];
    for (Plane plane in image.planes) {
      bytes += plane.bytes;
    }
    return Uint8List.fromList(bytes);
  }

  Future<File> saveImageToTempFile(Uint8List imageBytes) async {
    // Create a temporary directory
    Directory tempDir = await Directory.systemTemp.createTemp();

    // Define the file path for the temporary image
    String tempFilePath = '${tempDir.path}/temp_image.jpg';

    // Check if the file already exists, and if so, delete it
    File tempFile = File(tempFilePath);
    if (await tempFile.exists()) {
      await tempFile.delete();
    }

    // Write the image bytes to the temporary file
    await tempFile.writeAsBytes(imageBytes);

    return tempFile;
  }

  Future<List<dynamic>> detectFromAPI2(CameraImage cameraImage) async {
    // Convert CameraImage to Uint8List
    Uint8List imageBytes = convertPyTorchCameraImageToBytes(cameraImage);

    // Save the image to a temporary file
    File tempFile = await saveImageToTempFile(imageBytes);

    // Base64 Encode
    String encodedFile;
    List<int> bytes = await tempFile.readAsBytes();
    encodedFile = base64Encode(Uint8List.fromList(bytes));

    String api_key = Config.roboflowAPIKey; // Your API Key
    String modelEndpoint =
        'shape-recognition/4'; // Set model endpoint (Found in Dataset URL)

    // Construct the URL
    String uploadURL =
        'https://detect.roboflow.com/$modelEndpoint?api_key=$api_key&name=YOUR_IMAGE.jpg';

    // Http Request
    HttpClient client = HttpClient();

    try {
      // Configure connection to URL
      HttpClientRequest request = await client.postUrl(Uri.parse(uploadURL));
      request.headers.set('Content-Type', 'application/x-www-form-urlencoded');
      request.headers.set('Content-Length', encodedFile.length.toString());
      request.headers.set('Content-Language', 'en-US');
      request.headers.set('Connection', 'keep-alive');

      // Send request
      request.add(utf8.encode(encodedFile));
      HttpClientResponse response = await request.close();

      // Get Response
      if (response.statusCode == 200) {
        // Handle successful response here
        final responseBody = await response.transform(utf8.decoder).join();
        print('Response Data: $responseBody');

        return [];
      } else {
        // Handle error response here
        print('Error: ${response.statusCode}');

        return [];
      }
    } catch (error) {
      // Handle any exceptions or network errors
      print('Error: $error');

      return [];
    } finally {
      client.close();
    }
  }

  Future<List<dynamic>> detectFromAPI(CameraImage cameraImage) async {
    String testUrl =
        "https://detect.roboflow.com/shapes-recognition/4?api_key=UJNEhzlNoMK7w8jzXoHC&format=image&stroke=2";

    // Convert the CameraImage to a format that can be processed by the image package
    img.Image? image = img.Image.fromBytes(
      cameraImage.width,
      cameraImage.height,
      cameraImage.planes[0].bytes,
      format: img.Format.bgra,
    );

    if (image != null) {
      // Resize the image to 640x640 pixels
      img.Image resizedImage = img.copyResize(image, width: 640, height: 640);

      // Clear InkFlow AI Folder
      await deleteImagesInFolder();

      // Get the directory for saving the file
      final directory = await getApplicationDocumentsDirectory();
      final inkflowAIFolder = Directory('${directory.path}/Inkflow AI');
      if (!inkflowAIFolder.existsSync()) {
        inkflowAIFolder.createSync(recursive: true);
      }

      // Generate a unique file name
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${inkflowAIFolder.path}/image_$timestamp.jpg';

      // Save the resized image to the local storage
      File(filePath)
        ..writeAsBytesSync(img.encodeJpg(resizedImage))
        ..createSync();

      print('Image saved to: $filePath');

      String base64Image = await getImageAsBase64String(filePath);

      // Prepare the request headers
      Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        // 'Content-Type': 'application/json',
        // 'Content-Length': (base64Image.length + 12).toString(),
        // 'Content-Language': 'en-US',
        // 'Connection': 'keep-alive',
        // 'charset': 'utf-8',
        // 'Authorization': 'Bearer $apiKey',
      };

      // Encode the base64 image data in URL-encoded format
      String encodedImage = Uri.encodeComponent(base64Image);

      var res = await RequestAssistant.postRequest(testUrl,
          headers: headers, body: "image=$encodedImage");

      if (res != "Failed") {
        print("=============");
        print(res);

        List<dynamic> recognitions = [];
        recognitions.addAll(res["predictions"]);

        return recognitions;
      } else {
        print("======FAILED=======");
        return [];
      }
    } else {
      return [];
    }

    // // Encode the image bytes to base64
    // String imageBase64 = base64Encode(imageBytes2);
    // String base64Image = await convertCameraImageToBase64(cameraImage);

    // Set model endpoint (Found in Dataset URL)
    // String modelEndpoint = '${Config.model}/4';

    // // Set your API endpoint and key
    // String imageName = DateTime.now().millisecondsSinceEpoch.toString();

    // String apiKey = Config.roboflowAPIKey;
    // String apiUrl = // 'https://detect.roboflow.com/${Config.model}/42';
    //     'https://detect.roboflow.com/$modelEndpoint?api_key=$apiKey&name=YOUR_IMAGE.jpg';
  }

  Future<String> getImageAsBase64String(String imagePath) async {
    try {
      // Read the image file as bytes
      final File imageFile = File(imagePath);
      List<int> imageBytes = await imageFile.readAsBytes();

      // Encode the image bytes to base64
      String base64String = base64Encode(imageBytes);

      return base64String;
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  Future<void> deleteImagesInFolder() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final inkflowAIFolder = Directory('${directory.path}/Inkflow AI');

      if (inkflowAIFolder.existsSync()) {
        final fileList = inkflowAIFolder.listSync();

        for (final file in fileList) {
          if (file is File) {
            await file.delete();
            print('Deleted: ${file.path}');
          }
        }

        print('All images in Inkflow AI folder deleted.');
      } else {
        print('Inkflow AI folder does not exist.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String> convertCameraImageToBase64(CameraImage cameraImage) async {
    // Convert CameraImage to bytes
    List<int> imageBytes = await convertCameraImageToBytes(cameraImage);

    // Encode the bytes as base64
    String base64String = base64Encode(Uint8List.fromList(imageBytes));

    return base64String;
  }

  Future<List<int>> convertCameraImageToBytes(CameraImage cameraImage) async {
    // Create a ByteBuffer from the CameraImage planes
    final List<Uint8List> planes = cameraImage.planes.map((plane) {
      return plane.bytes;
    }).toList();

    // Calculate the total number of bytes
    int totalBytes = planes.fold(0, (count, plane) => count + plane.length);

    // Create a single Uint8List with all the bytes
    final Uint8List concatenatedBytes = Uint8List(totalBytes);
    int offset = 0;
    for (final Uint8List planeBytes in planes) {
      concatenatedBytes.setRange(
          offset, offset + planeBytes.length, planeBytes);
      offset += planeBytes.length;
    }

    return concatenatedBytes.toList();
  }

  @override
  void dispose() {
    controller?.stopImageStream();
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller!.value.previewSize!;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller!),
    );
  }
}
