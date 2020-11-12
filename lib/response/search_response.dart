class SearchResponse {
  final int id;
  final String key;
  final String title;
  final String description;
  final ThumbnailResponse thumbnailResponse;

  SearchResponse(
      {this.id,
      this.key,
      this.title,
      this.description,
      this.thumbnailResponse});

  SearchResponse.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        key = map["key"],
        title = map["title"],
        description = map["description"],
        thumbnailResponse = map["thumbnail"] != null ? ThumbnailResponse.fromJson(map["thumbnail"]) : null;


}

class ThumbnailResponse {
  final String type;
  final int size;
  final int width;
  final int height;
  final String url;

  ThumbnailResponse({this.type, this.size, this.width, this.height, this.url});

  ThumbnailResponse.fromJson(Map<String, dynamic> map)
      : type = map['mimetype'],
        size = map['size'],
        width = map['width'],
        height = map['height'],
        url = map['url'];
}
