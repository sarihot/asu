import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class LiveChat extends StatefulWidget {
  const LiveChat({super.key});

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  final String title = "Online Agent";
  final String selectedUrl = '';

 //final  Completer<WebViewController>  _controller =
   //   Completer<WebViewController>();

  int position = 1;
  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Live Chat",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          title: Text(
            "Live Chat",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0),
              child: InkWell(
                splashColor: Colors.blue,
                highlightColor: Colors.blue.withOpacity(0.5),
                onTap: () {
                  print("back");
                  Navigator.pop(context, true);
                },
                child: Icon(Icons.arrow_back,
                color: Colors.red,
                size: 30.0,),
              ),
            )
          ],
        ),
        body: IndexedStack(
          index: position,
          children: <Widget>[
            WebView(
              initialUrl:' https://tawk.to/chat/6550f525958be55aeaaedfb5/1hf23r6sc',
              javascriptMode: JavascriptMode.unrestricted,
              key: key,
              onPageFinished: doneLoading,
              onPageStarted: startLoading,
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
