class Note {
  final int? id;
  final String? title;
  final String? content;
  final String? dateTimeCreated;
  final String? dateTimeEdited;

  Note(
      {this.id,
      this.title,
      this.content,
      this.dateTimeCreated,
      this.dateTimeEdited});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "dateTimeEdited": dateTimeEdited,
      "dateTimeCreated": dateTimeCreated,
    };
  }

  Note.fromMap(Map<String, dynamic> maps)
      : id = maps['id'],
        title = maps['title'],
        content = maps['content'],
        dateTimeCreated = maps['dateTimeCreated'],
        dateTimeEdited = maps['dateTimeEdited'];
}
