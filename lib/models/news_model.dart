// ignore_for_file: public_member_api_docs, sort_constructors_first
class News {
  String? author;
  String title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  News({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
  });
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      content: json['content'],
    );
  }
}
