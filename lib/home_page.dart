import 'package:flutter/material.dart';

import 'news_list.dart';

class HomePage extends StatefulWidget {
	HomePage({Key key}) : super(key: key);

	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

	final List<String> categories = [
		'Business', 'Politics', 'Sport', 'Education',
		'Science', 'Technology', 'Weather', 'Travel',
		'Music', 'Food'
	];

	@override
	Widget build(BuildContext context) {
		return DefaultTabController(
			length: 10,
			child: Scaffold(
				appBar: AppBar(
					title: Text('News App'),
					bottom: TabBar(
						isScrollable: true,
						tabs: categories.map((e) => Tab(text: e)).toList()
					),
				),
				body: SafeArea(
					child: TabBarView(
						children: categories.map((e) => NewsList(e)).toList()
					)
				),
			),
		);
	}
}