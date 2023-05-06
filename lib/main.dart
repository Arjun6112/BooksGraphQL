import 'package:flutter/material.dart';
import 'package:graphql_basics/dialog_box.dart';
import 'package:graphql_basics/graphql_service.dart';

import 'book_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BookModel>? _books;
  GraphQLService _graphQLService = GraphQLService();

  TextEditingController _idController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    _books = null;
    _books = await _graphQLService.getBooks(limit: 50);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Books",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: _books == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _books!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_books![index].title),
                    subtitle: Text(_books![index].author),
                    trailing: IconButton(
                      onPressed: () async {
                        bool res = await _graphQLService.deleteBook(
                            id: _books![index].id!);
                        if (res) {
                          _load();
                        }
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return MyAlertBox(
                    titlecontroller: _titleController,
                    idcontroller: _idController,
                    yearcontroller: _yearController,
                    authorcontroller: _authorController,
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                    onSave: () async {
                      Navigator.of(context).pop();
                      bool res = await _graphQLService.createBook(
                          title: _titleController.text,
                          author: _authorController.text,
                          year: int.parse(_yearController.text.toString()));
                      _load();
                      _authorController.clear();
                      _titleController.clear();
                      _yearController.clear();
                    },
                  );
                });
          }),
    );
  }
}
