import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {

  //Set loader for indicating the page is loading

  late final WebViewController _controller;

  @override
  void initState(){
    super.initState();

    final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress){
          print("URL loading progress $progress");

        },
        onPageStarted: (String url){
          EasyLoading.instance
              ..indicatorType = EasyLoadingIndicatorType.fadingCircle
              ..loadingStyle = EasyLoadingStyle.dark;
          EasyLoading.show(status:"Please wait!");
        },
        onPageFinished: (String url){
            EasyLoading.dismiss();
      }
      ))
    ..loadRequest(Uri.parse('https://flutter.dev/'));
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller:_controller);
  }
}
