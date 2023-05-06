import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final titlecontroller;
  final idcontroller;
  final authorcontroller;
  final yearcontroller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const MyAlertBox({
    super.key,
    required this.onSave,
    required this.onCancel,
    this.titlecontroller,
    this.idcontroller,
    this.authorcontroller,
    this.yearcontroller,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: Column(
        children: [
          TextField(
            controller: titlecontroller,
            style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            decoration: InputDecoration(
              hintText: "Book Title",
              hintStyle: TextStyle(color: Colors.grey[600]),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: authorcontroller,
            style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            decoration: InputDecoration(
              hintText: "Author",
              hintStyle: TextStyle(color: Colors.grey[600]),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: yearcontroller,
            style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            decoration: InputDecoration(
              hintText: "Year Published",
              hintStyle: TextStyle(color: Colors.grey[600]),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // TextField(
          //   controller: idcontroller,
          //   style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          //   decoration: InputDecoration(
          //     hintText: "Book ID",
          //     hintStyle: TextStyle(color: Colors.grey[600]),
          //     enabledBorder: const OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.white)),
          //     focusedBorder: const OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.white)),
          //   ),
          // ),
        ],
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Colors.black,
          child: const Text(
            "Post",
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: Colors.black,
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
