import 'package:flutter/material.dart';
import 'package:news_app/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'News App',
			theme: ThemeData(
				primarySwatch: Colors.blue,
				visualDensity: VisualDensity.adaptivePlatformDensity,
			),
			home: HomePage(),
			debugShowCheckedModeBanner: false,
		);
	}
}
