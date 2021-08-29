class NoteForListing {
  final noteID;
  final noteTitle;
  final createDateTime;
  final latestEditDateTime;

  NoteForListing(
      {this.createDateTime,
      this.latestEditDateTime,
      this.noteID,
      this.noteTitle});

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      createDateTime: DateTime.parse(item['createDateTime']),
      latestEditDateTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }
}
