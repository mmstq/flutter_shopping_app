/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteBottomSheet extends StatefulWidget {

  final updatedNote;
  final String buttonText;
  final int index;

  NoteBottomSheet({this.updatedNote=const {'content':'','title':''}, this.buttonText, this.index});

  @override
  _NoteBottomSheetState createState() => _NoteBottomSheetState();
}

class _NoteBottomSheetState extends State<NoteBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController titleController;
  TextEditingController contentController;

  bool isSaved = false;

  border(Color color) =>
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color));

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController(text: widget.updatedNote['content']);
    titleController = TextEditingController(text: widget.updatedNote['title']);
  }

  @override
  Widget build(BuildContext context) {
    Data.buildContext = context;
    final screen = MediaQuery.of(context);
    return ChangeNotifierProvider<NoteSaveNotifier>(
      create: (context) => service<NoteSaveNotifier>(),
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(
              left: 10, right: 10, top: 20, bottom: screen.viewInsets.bottom),
          color: Theme
              .of(context)
              .scaffoldBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: titleController,
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty) return "Enter Title";
                  return null;
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    hintText: " Title",
                    prefixIcon: Icon(
                      Icons.title,
                      color: Colors.white,
                    ),
                    enabledBorder: border(Theme
                        .of(context)
                        .primaryColor),
                    errorBorder: border(Colors.red),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: contentController,
                maxLines: 3,
                validator: (value) {
                  if (value.isEmpty) return "Enter Content";
                  return null;
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    hintText: " Content",
                    prefixIcon: Icon(
                      Icons.assignment,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                        BorderSide(color: Theme
                            .of(context)
                            .primaryColor)),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
              SizedBox(
                height: 25,
              ),
              Consumer<NoteSaveNotifier>(builder: (context, model, child) {
                return InkWell(
                    child: AnimatedContainer(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                (model.state == NoteStates.Busy) ? 50 : 5),
                            border: Border.all(
                              color: Theme
                                  .of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor,
                            )),
                        width: model.state == NoteStates.Busy
                            ? MediaQuery
                            .of(context)
                            .size
                            .width * 0.1
                            : screen.size.width * 0.3,
                        height: MediaQuery
                            .of(context)
                            .size
                            .width * 0.1,
                        duration: Duration(milliseconds: 200),
                        child: Center(
                          child: getButton(model.state, widget.buttonText),
                        )),
                    onTap: () async {
                      if (_formKey.currentState.validate()) {

                        widget.updatedNote['title']=titleController.value.text;
                        widget.updatedNote['content']=contentController.value.text;

                        if(widget.buttonText=='Save') {

                          widget.updatedNote['time']=DateTime.now().toIso8601String();

                      print(widget.updatedNote);
                          await model.saveNote(widget.updatedNote);
                        }else
                          await model.updateNote(widget.updatedNote, widget.index);

                        Navigator.of(context).pop();
                      }
                    });
              }),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getButton(NoteStates state, String buttonStatus) {
    if (state == NoteStates.Done)
      return Text('${buttonStatus}d', style: TextStyle(
          fontFamily: 'Ubuntu', color: Colors.lightGreenAccent.shade700),);
    else if (state == NoteStates.Idle)
      return Text(buttonStatus);
    else
      return CircularProgressIndicator(strokeWidth: 1);
  }
}
*/
