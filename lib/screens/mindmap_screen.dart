import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../data/secrets.dart';
import '../service/api_service.dart';

class MindMap extends StatefulWidget {
  final String data;

  const MindMap({Key? key, required this.data}) : super(key: key);

  @override
  State<MindMap> createState() => _MindMapState();
}

class _MindMapState extends State<MindMap> {
  String html = '';

  Future<void> fetchData(String qry) async {
    const String key = apiKey;
    String fetchRes = await ApiService.fetchApi(key, qry);

    setState(() {
      html = '''
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
  </head>
  <body>
    <div class="card" style="display:block">
      <div class="card-content">
        <div class="mermaid">
       $fetchRes
        </div>
      </div>
    </div>
    <script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
</script>
  </body>
</html>
''';
      if (kDebugMode) {
        print(html);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: itrans,
        foregroundColor: Colors.white,
        title: const Text("Mind Map"),
      ),
      body: Container(
        child: (html == '')
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Generating Mind Map...',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 80.0),
                    child: LinearProgressIndicator(
                      minHeight: 3,
                      color: iradium,
                    ),
                  ),
                ],
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: WebViewPlus(
                  backgroundColor: Colors.black,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer()),
                  },
                  zoomEnabled: true,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    controller.loadString(html);
                  },
                ),
              ),
      ),
    );
  }
}
