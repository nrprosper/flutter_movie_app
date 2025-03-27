import 'package:flutter/material.dart';
import 'package:movie_app/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayScreen extends StatefulWidget {
  final int id;

  const VideoPlayScreen({super.key, required this.id});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    String videoUrl = 'https://player.vidsrc.co/embed/movie/${widget.id}';
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(MColors.themeBlack)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(videoUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}