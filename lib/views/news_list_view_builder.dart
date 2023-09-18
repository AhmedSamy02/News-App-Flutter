import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/enums/categories.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_services.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListViewBuilder extends StatelessWidget {
  const NewsListViewBuilder({super.key});

//Here it listens only on the future value
//but it doesn't execute or trrigger the function again
//and by that it doesn't consume many request everytime the widgets are built

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
      future: NewsServices.instance.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return newsList(
            snapshot.data!,
          );
        } else if (snapshot.hasError) {
          const SliverToBoxAdapter(
            child: Center(
              child: Text('Oops There\'s an error'),
            ),
          );
        }
        return const SliverToBoxAdapter(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget newsList(List<News> data) {
    return SliverList.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return newsItem(context, data[index]);
      },
    );
  }
Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }
  Widget newsItem(BuildContext context, News data) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        elevation: 10,
        child: GestureDetector(
          onTap: () {
            _launchURL(data.url!);
          },
          child: Container(
            color: Colors.white24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: data.urlToImage ?? '',
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    data.title ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
                  child: Text(
                    data.description ?? 'N/A',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
