import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  late var url;
  double prgress = 0;
  var urlController = TextEditingController();
  var initialUrl = "https://www.thereporterethiopia.com/addis-events/";
  var isLoading = false;

  Future<bool> _goBack(BuildContext context) async{
    if(await webViewController!.canGoBack()){
      webViewController!.goBack();
      return Future.value(false);
    }
    else{
      SystemNavigator.pop();
      return Future.value(true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshController = PullToRefreshController(
      onRefresh: (){
        webViewController!.reload();
      },
      options: PullToRefreshOptions(
        color: Colors.red,
        backgroundColor: Colors.white,
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web View App',style: TextStyle(
          color: Colors.white
        ),),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change this color to the desired color
        ),
        backgroundColor: Colors.red,
        shape: const RoundedRectangleBorder(),
        actions: <Widget>[
          IconButton(
            icon:const Icon(Icons.arrow_back),
            onPressed: () async {
              if (webViewController != null) {
                if (await webViewController!.canGoBack()) {
                  webViewController!.goBack();
                }
              }
            },
          ),

          IconButton(
            icon:const Icon(Icons.arrow_forward),
            onPressed: () async {
              if (webViewController != null) {
                if (await webViewController!.canGoForward()) {
                  webViewController!.goForward();
                }
              }
            },
          ),

          IconButton(
            icon:const Icon(Icons.refresh),
            onPressed: () async {
              if (webViewController != null) {
                if (await webViewController!.canGoForward()) {
                  webViewController!.goForward();
                }
              }
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () => _goBack(context),
        child: Column(
          children: [Expanded(child: Stack(
            alignment: Alignment.center,
            children: [
              InAppWebView(
                onLoadStart:(controller, url){
                  setState(() {
                    isLoading = true;
                  });
                },
                onLoadStop: (controller,url){
                  refreshController!.endRefreshing();
                  setState((){
                    isLoading = false;
                  });
                },
                // onProgressChanged: (controller, progress){
                //   if(progress == 100){
                //     refreshController!.endRefreshing();
                //   }
                //   setState(() {
                //     this.progress = progress/100;
                //   });
                // },
                pullToRefreshController: refreshController,
                onWebViewCreated: (controller)=> webViewController = controller,
                initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(initialUrl))),
              ),
               Visibility(
                visible:isLoading,
                  child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red),
              )),
            ],
          ))],
        ),
      ),
    );
  }
}
