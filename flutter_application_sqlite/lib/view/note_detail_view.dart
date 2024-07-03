import 'package:flutter/material.dart';
import 'package:flutter_application_sqlite/model/note_databas.dart';
import 'package:flutter_application_sqlite/model/note_model.dart';

class NoteDetailsView extends StatefulWidget {
  const NoteDetailsView({super.key, this.noteId});
  final int? noteId;

  @override
  State<NoteDetailsView> createState() => _NoteDetailsViewState();
}

class _NoteDetailsViewState extends State<NoteDetailsView> {
  NoteDatabase noteDatabase = NoteDatabase.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  late NoteModel note;
  bool isLoading = false;
  bool isNewNote = false;
  bool isFavorite = false;

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  ///Gets the note from the database and updates the state if the noteId is not null else it sets the isNewNote to true
  refreshNotes() {
    if (widget.noteId == null) {
      setState(() {
        isNewNote = true;
      });
      return;
    }
    noteDatabase.read(widget.noteId!).then((value) {
      setState(() {
        note = value;
        titleController.text = note.title;
        contentController.text = note.content;
        isFavorite = note.isFavorite;
      });
    });
  }

  ///Creates a new note if the isNewNote is true else it updates the existing note
  createNote() {
    setState(() {
      isLoading = true;
    });
    final model = NoteModel(
      title: titleController.text,
      number: 1,
      content: contentController.text,
      isFavorite: isFavorite,
      createdTime: DateTime.now(),
    );
    if (isNewNote) {
      noteDatabase.create(model);
    } else {
      model.id = note.id;
      noteDatabase.update(model);
    }
    setState(() {
      isLoading = false;
    });
  }

  ///Deletes the note from the database and navigates back to the previous screen
  deleteNote() {
    noteDatabase.delete(note.id!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(!isFavorite ? Icons.favorite_border : Icons.favorite),
          ),
          Visibility(
            visible: !isNewNote,
            child: IconButton(
              onPressed: deleteNote,
              icon: const Icon(Icons.delete),
            ),
          ),
          IconButton(
            onPressed: createNote,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(children: [
                  TextField(
                    controller: titleController,
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    controller: contentController,
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Type your note here...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ]),
        ),
      ),
    );
  }
}
