import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/main.dart';

class ModifyBooks extends StatefulWidget {
  final BookStore bookStore;

  ModifyBooks({@required this.bookStore});
  @override
  _ModifyBooksState createState() => _ModifyBooksState();
}

class _ModifyBooksState extends State<ModifyBooks> {
  final _formKey = GlobalKey<FormState>();

  String title;
  String author;

  @override
  Widget build(BuildContext context) {
    var bookstoreProvider = Provider.of<FirebaseCRUDoperations>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Изменить информацию о книге'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                      initialValue: widget.bookStore.name,
                      decoration: InputDecoration(
                        labelText: 'Название книги',
                        filled: true,
                        isDense: true,
                      ),
                      autocorrect: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, введите название книги';
                        }
                        return null;
                      },
                      onSaved: (value) => title = value),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                      initialValue: widget.bookStore.author,
                      decoration: InputDecoration(
                        labelText: 'Автор',
                        filled: true,
                        isDense: true,
                      ),
                      autocorrect: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, введите автора';
                        }
                        return null;
                      },
                      onSaved: (value) => author = value),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await bookstoreProvider.updateBookStore(
                        BookStore(
                          name: title,
                          author: author,
                          img: widget.bookStore.img,
                        ),
                        widget.bookStore.id);
                    Navigator.pop(context);
                  } else {
                    print('no Validate');
                  }
                },
                child: Text(
                  'Обновить информацию о книге',
                )),
          )
        ],
      ),
    );
  }
}
