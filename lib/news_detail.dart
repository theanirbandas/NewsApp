import 'package:flutter/material.dart';
import 'package:news_app/news.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
	
	final News news;
	
	NewsDetail(this.news, {Key key}) : super(key: key);

	@override
	_NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('News Detail'),
			),
			body: SafeArea(
				child: WebView(
					initialUrl: widget.news.url,
					javascriptMode: JavascriptMode.unrestricted,
				)
			),
		);
	}
}