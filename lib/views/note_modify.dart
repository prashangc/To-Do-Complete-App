import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do/models/note.dart';
import 'package:to_do/models/note_insert.dart';
import 'package:to_do/models/note_manipulation.dart';
import 'package:to_do/services/notes_service.dart';

class NoteModify extends StatefulWidget {
  final noteID;
  NoteModify({this.noteID});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NoteService get notesService => GetIt.I<NoteService>();

  late String errorMessage;
  late Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });

      notesService.getNote(widget.noteID).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occured';
        }
        note = response.data;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: unnecessary_null_comparison
        title: Text(isEditing ? 'Edit Note' : 'Create Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Note Title',
                    ),
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      hintText: 'Note Content',
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (isEditing) {
                          setState(() {
                            _isLoading = true;
                          });

                          final note = NoteManipulation(
                            noteContent: _titleController.text,
                            noteTitle: _contentController.text,
                          );
                          final result = await notesService.updateNote(
                              widget.noteID, note);
                          setState(() {
                            _isLoading = false;
                          });
                          final title = 'done';
                          final text = result.error
                              ? (result.errorMessage ?? 'An Error Occured')
                              : 'Your note was updated.';
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(title),
                              content: Text(text),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ok')),
                              ],
                            ),
                          ).then((data) {
                            if (result.data) {
                              Navigator.of(context).pop();
                            }
                          });
                        } else {
                          setState(() {
                            _isLoading = true;
                          });

                          final note = NoteInsert(
                            noteContent: _titleController.text,
                            noteTitle: _contentController.text,
                          );
                          final result = await notesService.createNote(note);
                          setState(() {
                            _isLoading = false;
                          });
                          final title = 'done';
                          final text = result.error
                              ? (result.errorMessage ?? 'An Error Occured')
                              : 'Your note was created.';
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(title),
                              content: Text(text),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ok')),
                              ],
                            ),
                          ).then((data) {
                            if (result.data) {
                              Navigator.of(context).pop();
                            }
                          });
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
