class NoteManipulation {
  String noteTitle;
  String noteContent;

  NoteManipulation({required this.noteContent, required this.noteTitle});

  Map<String, dynamic> toJson() {
    return {
      "noteTitle": noteTitle,
      "noteContent": noteContent,
    };
  }
}
