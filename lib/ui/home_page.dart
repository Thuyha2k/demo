import 'dart:async';
import 'dart:developer' as developer;
import 'package:demo/bloc/monan_bloc.dart';
import 'package:demo/bloc/monan_state.dart';
import 'package:demo/ui/add_menu.dart';
import 'package:demo/ui/update_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  final bloc = MenuCubit(monan);
  late TextEditingController searchController;
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.init();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MenuCubit>(
        create: (context) => bloc,
        child: BlocConsumer<MenuCubit, MenuState>(
          builder: (context, state) {
            developer.log("state" + state.toString());
            if (state is MenuStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MenuStateError) {
              return Center(
                  child: RichText(
                    text: const TextSpan(
                        text: 'Failed when load data',
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ));
            } else if (state is MenuStateLoaded) {
              return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddMenu(monAn: state.listMenu[state.listMenu.length - 1])))
                          .then((value) {
                        developer.log("data pop: " + value.toString());
                        bloc.addListMenu(monAn: value);
                      });
                    },
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
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: TextField(
                          onChanged: (value){
                            if (_debounce?.isActive ?? false) _debounce?.cancel();
                            _debounce = Timer(const Duration(milliseconds: 1000), () {
                              bloc.searchListMenu(searchText: value);
                            });

                          },
                          onSubmitted: (value){

                          },
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Tim kiem',
                            hintStyle: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
                            prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20,)
                          ),
                        ),
                      ),
                      Expanded(child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.listMenu.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateMenu(monAn: state.listMenu[i])))
                                  .then((value) {
                                bloc.updateListMenu(index: i, monAn: value);
                              });
                            },
                            child: Slidable(
                              endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (value) {
                                        showDialog(context: value, builder: (value) {
                                          return AlertDialog(
                                            backgroundColor: Colors.grey,
                                            content: RichText(text: const TextSpan(
                                                text: 'are you sure delete it?'),),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    bloc.deleteItemMenu(index: i);
                                                    Navigator.pop(value);
                                                    developer.log(state.toString());
                                                  },
                                                  child: RichText(
                                                      text: const TextSpan(text: 'Yess'))),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(value);
                                                  },
                                                  child: RichText(
                                                      text: const TextSpan(text: 'Noo'))),
                                            ],
                                          );
                                        });
                                      },
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    )
                                  ]),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            text: state.listMenu[i].name,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic))),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                                text: 'Nguồn gốc: ${state.listMenu[i]
                                                    .origin}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.italic))),
                                        RichText(
                                            text: TextSpan(
                                                text: 'So luong: ${state.listMenu[i].count}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.italic)))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),)

                    ],
                  ));
            } else {
              return Center(
                  child: RichText(
                    text: const TextSpan(
                        text: 'Failed when load data',
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ));
            }
          },
          listener: (context, state) {

          },
        ),
      ),
    );
  }
}
