import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'error_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  var internetDisconnected = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          // setState(() {
          //   loadingPercentage = 0;
          // });
        },
        onProgress: (progress) {
          // setState(() {
          //   loadingPercentage = progress;
          // });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
        onWebResourceError: (error) {
          if (error.errorType == WebResourceErrorType.hostLookup) {
            setState(() {
              internetDisconnected = true;
            });
          }
        },
      ))
      ..loadRequest(
        Uri.parse('https://bankie.springwellinvestment.com/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          !internetDisconnected
              ? WebViewWidget(
                  controller: controller,
                )
              : const ErrorScreen(),
          if (loadingPercentage < 100)
            const Center(
              child: CircularProgressIndicator(
                  // value: loadingPercentage / 100.0,
                  ),
            ),
        ],
      ),
    );
  }
}
