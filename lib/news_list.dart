import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/news.dart';
import 'package:news_app/news_item.dart';

class NewsList extends StatefulWidget {
	
	final String categorie;
	
	NewsList(this.categorie, {Key key}) : super(key: key);

	@override
	_NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {

	bool _isLoading = false;
	bool _loadingFailed = false;

	List<News> _newsItems = [];

	void _loadNews() async {
		if(mounted) {
			setState(() {
				_isLoading = true;
				_loadingFailed = false;
			});
		}
		
		try {
			Response response = await Dio().get(
				'https://content.guardianapis.com/search',
				queryParameters: {
					'section': widget.categorie.toLowerCase(),
					'api-key': 'test',
					'show-fields': 'thumbnail,trailText',
					'page-size': 25
				}
			);

			_newsItems = (response.data['response']['results'] as List).map((item) => News(
				id: item['id'],
				title: item['webTitle'],
				categorie: item['sectionName'],
				description: item['fields']['trailText'],
				date: item['webPublicationDate'],
				thumbnail: item['fields']['thumbnail'],
				url: item['webUrl']
			)).toList();

			if(mounted) {
				setState(() {
					_isLoading = false;
					_loadingFailed = false;
				});
			}
		} catch (e) {
			if(mounted) {
				setState(() {
					_isLoading = false;
					_loadingFailed = true;
				});
			}
		}
	}

	@override
	void initState() {
		super.initState();

		WidgetsBinding.instance.addPostFrameCallback((_) => _loadNews());
	}

	@override
	Widget build(BuildContext context) {
		return Container(
			child: _isLoading ? 
				_loadingView() :
				!_isLoading && _loadingFailed ?
				_loadingFailedView() :
				_newsView() 
		);
	}

	Widget _newsView() {
		return ListView.builder(
			padding: const EdgeInsets.all(5.0),
			itemCount: _newsItems.length,
			itemBuilder: (context, i) => NewsItem(_newsItems[i])
		);
	}

	Widget _loadingView() {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				const Text(
					'Please Wait While News Is Loading...',
					style: TextStyle(
						fontSize: 16.0,
						fontWeight: FontWeight.bold,
						color: Colors.blueGrey
					),
				),
				const SizedBox(height: 20.0),
				CircularProgressIndicator()
			],
		);
	}

	Widget _loadingFailedView() {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				Padding(
					padding: const EdgeInsets.all(10.0),
					child: const Text(
						'Loading Failed! Click Reload to Try Again.',
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.bold,
							color: Colors.blueGrey
						),
					),
				),
				const SizedBox(height: 10.0),
				IconButton(
					icon: Icon(Icons.replay), 
					iconSize: 36.0,
					onPressed: () => _loadNews()
				)
			],
		);
	}
}