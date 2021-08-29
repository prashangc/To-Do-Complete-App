class Note {
  final noteID;
  final noteTitle;
  final noteContent;
  final createDateTime;
  final latestEditDateTime;

  Note(
      {this.noteID,
      this.createDateTime,
      this.latestEditDateTime,
      this.noteContent,
      this.noteTitle});

  factory Note.fromJson(Map<String, dynamic> item) {
    return Note(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      noteContent: item['noteContent'],
      createDateTime: DateTime.parse(item['createDateTime']),
      latestEditDateTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }
}
