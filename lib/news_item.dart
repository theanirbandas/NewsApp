import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/news_detail.dart';

class NewsItem extends StatelessWidget {

	final News news;

	const NewsItem(this.news, {Key key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			child: Card(
				elevation: 7.0,
				shadowColor: Colors.grey[200].withOpacity(0.6),
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
				margin: const EdgeInsets.all(5.0),
				child: Padding(
					padding: const EdgeInsets.all(10.0),
					child: Column(
						mainAxisSize: MainAxisSize.min,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							CachedNetworkImage(
								width: double.infinity,
								fit: BoxFit.fill,
								imageUrl: news.thumbnail ?? 'https://via.placeholder.com/500x300?text=News',
								placeholder: (context, url) => Container(
									width: double.infinity,
									height: 200,
									alignment: Alignment.center,
									child: SizedBox(
										width: 48.0,
										height: 48.0,
										child: CircularProgressIndicator()
									)
								),
								errorWidget: (context, url, error) => Icon(Icons.error),
							),
							const SizedBox(height: 10.0),
							Text(
								news.title,
								maxLines: 2,
								overflow: TextOverflow.ellipsis,
								style: TextStyle(
									fontSize: 16.0,
									fontWeight: FontWeight.bold
								),
							),
							const SizedBox(height: 10.0),
							Text(
								news.description,
								maxLines: 4,
								overflow: TextOverflow.ellipsis,
								style: TextStyle(color: Colors.grey[700]),
							),
							const SizedBox(height: 10.0),
							Text(
								DateFormat("hh:mm a 'on' d MMM, y ").format(DateTime.parse(news.date)),
								overflow: TextOverflow.ellipsis,
								style: TextStyle(color: Colors.grey[700]),
							),
						],
					),
				),
			),
			onTap: () => Navigator.push(context, MaterialPageRoute(
				builder: (context) => NewsDetail(news)
			)),
		);
	}
}