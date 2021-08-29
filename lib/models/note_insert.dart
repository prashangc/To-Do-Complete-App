class NoteInsert {
  String noteTitle;
  String noteContent;

  NoteInsert({required this.noteContent, required this.noteTitle});

  Map<String, dynamic> toJson() {
    return {
      "noteTitle": noteTitle,
      "noteContent": noteContent,
    };
  }
}
