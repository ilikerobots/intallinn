class ContentEntry {
  final String id;
  String content;

  ContentEntry(this.id, this.content);

  factory ContentEntry.fromJson(Map<String, dynamic> c) => new ContentEntry(c['id'], c['content']);

  Map<String,String> toJson() => <String,String>{'id': id, 'content': content};
}
