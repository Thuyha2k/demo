
import 'package:demo/bloc/monan_state.dart';
import 'package:demo/model/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuCubit extends Cubit<MenuState>{

  MenuCubit(this.listMonan) : super(MenuStateInital());

  List<MonAn> listMonan;

  Future<void> init() async {
    emit(MenuStateLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(MenuStateLoaded(listMonan));
  }

  addListMenu({required MonAn monAn}) async {
    try {
      emit(MenuStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      listMonan.add(monAn);
      emit(MenuStateLoaded(listMonan));
    } catch (e) {
      emit(MenuStateError());
    }
  }

  updateListMenu({required int index, required MonAn monAn }) async {
    try{
      emit(MenuStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      listMonan[index] = monAn;
      emit(MenuStateLoaded(listMonan));
    } catch (e) {
      emit(MenuStateError());
    }
  }

  deleteItemMenu({required int index})async{
    try{
      emit(MenuStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      listMonan.removeAt(index);
      emit(MenuStateLoaded(listMonan));
    } catch (e) {
      emit(MenuStateError());
    }
  }

  searchListMenu({required String searchText}) async{
    List<MonAn> monAnNew =[];
    try{
      emit(MenuStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      monAnNew = listMonan.where((e)=>e.name.contains(searchText)).toList();
      // listMonan.map((e) => e.name.contains(searchText)).toList().forEach((element) {
      //   monAnNew.add(element);
      // });
      emit(MenuStateLoaded(monAnNew));
    } catch(e){
      emit(MenuStateError());
    }
  }

}