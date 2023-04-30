import 'package:flutter/material.dart';
import 'package:testbloc/db/notedb.dart';
import 'package:testbloc/models/notemodel.dart';
import 'package:testbloc/screens/homescreen.dart';
import 'package:testbloc/widget/colorbox.dart';

import '../widget/custome_button.dart';

class NoteScreen extends StatefulWidget {
  final NoteModel? note;
  const NoteScreen({
    this.note,
    super.key,
  });

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color color = const Color(0xFF8F43EE);
  bool isStared = false;
  @override
  void initState() {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _bodyController.text = widget.note!.description;
      color = Color(widget.note!.color);
      isStared = widget.note!.isStaredActive;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: color,
        actions: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  setState(() {});
                  isStared = !isStared;
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isStared ? Icons.star : Icons.star_border_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              if (widget.note != null)
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Are you sure?",
                        textAlign: TextAlign.start,
                      ),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        CustomButton(
                          buttonType: ButtonType.secondary,
                          text: "no",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        CustomButton(
                          text: "Yes",
                          onTap: () {
                            NoteDb.instace.delNote(widget.note!.id);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                autofocus: true,
                maxLines: null,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'enter title';
                  }
                  return null;
                },
                controller: _titleController,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                    ),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle:
                      Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.grey,
                          ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                onEditingComplete: () => FocusScope.of(context).unfocus(),
                style: Theme.of(context).textTheme.titleLarge,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'enter text';
                  }
                  return null;
                },
                controller: _bodyController,
                maxLines: null,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.grey,
                      ),
                  hintText: "Type something..",
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  ColorBox(
                    color: const Color(0xFF8F43EE),
                    onTap: () {
                      setState(
                        () {
                          color = const Color(0xFF8F43EE);
                        },
                      );
                    },
                    isActive: color == const Color(0xFF8F43EE),
                  ),
                  ColorBox(
                    color: const Color(0xFFEB7A53),
                    isActive: color == const Color(0xFFEB7A53),
                    onTap: () {
                      setState(
                        () {
                          color = const Color(0xFFEB7A53);
                        },
                      );
                    },
                  ),
                  ColorBox(
                    color: const Color(0xFF98B7DB),
                    isActive: color == const Color(0xFF98B7DB),
                    onTap: () {
                      setState(
                        () {
                          color = const Color(0xFF98B7DB);
                        },
                      );
                    },
                  ),
                  ColorBox(
                    color: const Color(0xFFA8D672),
                    isActive: color == const Color(0xFFA8D672),
                    onTap: () {
                      setState(
                        () {
                          color = const Color(0xFFA8D672);
                        },
                      );
                    },
                  ),
                  ColorBox(
                    color: const Color(0xFFF6ECC9),
                    isActive: color == const Color(0xFFF6ECC9),
                    onTap: () {
                      setState(
                        () {
                          color = const Color(0xFFF6ECC9);
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CustomButton(
        text: "Done",
        onTap: () {
          if (_formKey.currentState!.validate()) {
            if (widget.note == null) {
              NoteDb.instace.addNote(
                NoteModel(
                  _bodyController.text,
                  _titleController.text,
                  color.value,
                  isStared,
                  DateTime.now(),
                ),
              );
              Navigator.pop(context);
            } else {
              widget.note!.title = _titleController.text;
              widget.note!.description = _bodyController.text;
              widget.note!.color = color.value;
              widget.note!.isStaredActive = isStared;
              NoteDb.instace.addNote(widget.note!);
              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }
}
