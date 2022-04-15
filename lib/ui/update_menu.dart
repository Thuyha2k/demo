import 'dart:developer' as developer;
import 'package:demo/model/home.dart';
import 'package:flutter/material.dart';

class UpdateMenu extends StatelessWidget {
  MonAn monAn;
  UpdateMenu({Key? key, required this.monAn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController originController = TextEditingController();
    TextEditingController countController = TextEditingController();

    nameController.text = monAn.name.toString();
    originController.text = monAn.origin.toString();
    countController.text = monAn.count.toString();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              onChanged: (v){
                monAn.name = v;
              },
              controller: nameController,
              decoration: InputDecoration(
                label: RichText(text: const TextSpan(text: 'Name food')),
                labelStyle: const TextStyle(color: Colors.black),

              ),
            ),
            TextField(
              onChanged: (v){
                monAn.origin = v;
              },
              controller: originController,
              decoration: InputDecoration(
                label: RichText(text: const TextSpan(text: 'Origin food')),
                labelStyle: const TextStyle(color: Colors.black),
              ),
            ),
            TextField(
              onChanged: (v){
                monAn.count = int.parse(v);
              },
              controller: countController,
              decoration: InputDecoration(
                label: RichText(text: const TextSpan(text: 'Count food')),
                labelStyle: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  // onPressed: () => addMon(
                  //     MonAn(nameController.text, originController.text,
                  //         int.parse(countController.text.toString())
                  //     )
                  // ),
                  onPressed: () => Navigator.of(context).pop(monAn),
                  child: Center(
                    child: RichText(
                        text: const TextSpan(
                            text: 'Update menu',
                            style: TextStyle(fontSize: 14, color: Colors.black))),
                  ),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.cyan),
                ),
                TextButton(
                  // onPressed: () => addMon(
                  //     MonAn(nameController.text, originController.text,
                  //         int.parse(countController.text.toString())
                  //     )
                  // ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Center(
                    child: RichText(
                        text: const TextSpan(
                            text: 'Cancel',
                            style: TextStyle(fontSize: 14, color: Colors.black))),
                  ),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.cyan),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}