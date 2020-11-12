class Topic {
  final int id;
  final String key;
  final String title;
  final String description;
  final String thumbnail;

  Topic({this.id, this.key, this.title, this.description, this.thumbnail});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "key": key,
      "title": title,
      "description": description,
      "thumbnail": thumbnail
    };
  }

  Topic.fromMap(Map<String, dynamic> map):
      id = map['id'],
      key = map['key'],
      title = map['title'],
      description = map['description'],
      thumbnail = map['thumbnail'];
}