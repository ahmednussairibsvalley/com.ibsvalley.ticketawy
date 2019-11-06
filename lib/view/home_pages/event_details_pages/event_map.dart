import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Class for full-screen map
class LargerMap extends StatefulWidget {

  final String url;

  LargerMap({@required this.url});
  @override
  _LargerMapState createState() => _LargerMapState();
}

class _LargerMapState extends State<LargerMap> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: WebView(
        initialUrl: Uri.dataFromString('<iframe src="${widget.url}" width="$_width" height="$_height" frameborder="0" style="border:0;" allowfullscreen=""></iframe>', mimeType: 'text/html').toString(),
        javascriptMode: JavascriptMode.unrestricted,


      ),
    );
  }
}
