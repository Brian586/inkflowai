import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inkflowai/models/activity.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/camera_button.dart';
import '../../widgets/progress_widget.dart';

class PaintScreen extends StatefulWidget {
  final String activityID;
  const PaintScreen({super.key, required this.activityID});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  bool loading = false;
  bool isActive = false;
  // List<dynamic> _recognitions = [];
  // int _imageHeight = 0;
  // int _imageWidth = 0;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          userAgent: '',
          useShouldOverrideUrlLoading: true,
          useOnLoadResource: true,
          useOnDownloadStart: false,
          mediaPlaybackRequiresUserGesture: false,
          useShouldInterceptAjaxRequest: false,
          useShouldInterceptFetchRequest: false,
          supportZoom: false,
          allowUniversalAccessFromFileURLs: true,
          preferredContentMode: UserPreferredContentMode.MOBILE,
          clearCache: false,
          cacheEnabled: true,
          disableHorizontalScroll: true),
      android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
          builtInZoomControls: true,
          useShouldInterceptRequest: true,
          useOnRenderProcessGone: false,
          cacheMode: AndroidCacheMode.LOAD_DEFAULT,
          hardwareAcceleration: true
          // networkAvailable
          ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
        allowsLinkPreview: false,
        allowsBackForwardNavigationGestures: false,
      ));

  PullToRefreshController? pullToRefreshController;

  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

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
        .where(
          (element) => element.activityID == widget.activityID,
        )
        .toList()
        .first;

    return Stack(
      children: [
        InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: Uri.parse(activity.model!)),
          // contextMenu: contextMenu,
          initialOptions: options,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) async {
            webViewController = controller;
          },
          onLoadStart: (controller, url) async {
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (![
              "http",
              "https",
              "file",
              "chrome",
              "data",
              "javascript",
              "about"
            ].contains(uri.scheme)) {
              if (await canLaunchUrl(uri)) {
                // Launch the App
                await launchUrl(
                  uri,
                );
                // and cancel the request
                return NavigationActionPolicy.CANCEL;
              }
            }

            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            pullToRefreshController?.endRefreshing();
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          // onReceivedError: (controller, request, error) {
          //   pullToRefreshController?.endRefreshing();
          // },
          onProgressChanged: (controller, progress) {
            if (progress == 100) {
              pullToRefreshController?.endRefreshing();
            }
            setState(() {
              this.progress = progress / 100;
              urlController.text = this.url;
            });
          },
          onUpdateVisitedHistory: (controller, url, isReload) {
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          onConsoleMessage: (controller, consoleMessage) {
            print(consoleMessage);
          },
        ),
        progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AdaptiveUI(
      appbarTitle: "Colour Images",
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
