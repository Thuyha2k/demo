import 'dart:developer' as developer;
import 'package:flutter/material.dart';

import '../model/home.dart';

List<MonAn> monan = [
  MonAn('bun bo hue', 'hue mong mo', 10),
  MonAn('banh da ca', 'hai phong hoa phuong do', 10),
  MonAn('nem nuong', 'nha trang tuoi mat', 10),
];

class HomePage extends StatefulWidget {
  static const path = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Center(
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
        appBar: AppBar(
          title: RichText(
              text: const TextSpan(
                  text: 'Bloc Demo', style: TextStyle(fontSize: 24)),
              textAlign: TextAlign.center),
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: monan.length,
          itemBuilder: (context, i) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: monan[i].name,
                          style: const TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'Nguồn gốc: ${monan[i].origin}',
                              style: const TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic))),
                      RichText(
                          text: TextSpan(
                              text: 'So luong: ${monan[i].count}',
                              style: const TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic)))
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
