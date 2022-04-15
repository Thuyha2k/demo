import 'dart:developer' as developer;
import 'package:demo/model/home.dart';
import 'package:flutter/material.dart';

class AddMenu extends StatelessWidget {
  MonAn monAn;

  AddMenu({Key? key, required this.monAn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController originController = TextEditingController();
    TextEditingController countController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                label: RichText(text: const TextSpan(text: 'Name food')),
                labelStyle: const TextStyle(color: Colors.black),
                hintText: monAn.name,
              ),
            ),
            TextField(
              controller: originController,
              decoration: InputDecoration(
                label: RichText(text: const TextSpan(text: 'Origin food')),
                labelStyle: const TextStyle(color: Colors.black),
                hintText: monAn.origin,
              ),
            ),
            TextField(
              controller: countController,
              decoration: InputDecoration(
                label: RichText(text: const TextSpan(text: 'Count food')),
                labelStyle: const TextStyle(color: Colors.black),
                hintText: monAn.count.toString(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              // onPressed: () => addMon(
              //     MonAn(nameController.text, originController.text,
              //         int.parse(countController.text.toString())
              //     )
              // ),
              onPressed: () => Navigator.of(context).pop(
                MonAn(
                  nameController.text,
                  originController.text,
                  int.parse(
                    countController.text.toString(),
                  ),
                ),
              ),
              child: Center(
                child: RichText(
                    text: const TextSpan(
                        text: 'Add menu',
                        style: TextStyle(fontSize: 14, color: Colors.black))),
              ),
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: Colors.cyan),
            )
          ],
        ),
      ),
    );
  }
}
