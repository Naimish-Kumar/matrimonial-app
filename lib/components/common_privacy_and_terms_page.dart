import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonPrivacyAndTerms extends StatefulWidget {
  final String? title;
  final String? content;
  const CommonPrivacyAndTerms({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  State<CommonPrivacyAndTerms> createState() => _CommonPrivacyAndTermsState();
}

class _CommonPrivacyAndTermsState extends State<CommonPrivacyAndTerms> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  @override
  void initState() {
    super.initState();
    // print(widget.content);
    controller.loadHtmlString(html(widget.content!));
  }

  String html(body) {
    return ''' <!DOCTYPE html>
<html>
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" shrink-to-fit=no>
  <style>
  body{
  color: #6d6e6f;
  }
</style>
</head>

<body>
$body
</body>
  </html>
 ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(text: widget.title).build(context),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      height: DeviceInfo(context).height,
      width: DeviceInfo(context).width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
