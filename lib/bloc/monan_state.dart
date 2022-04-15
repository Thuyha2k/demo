import 'package:demo/model/home.dart';
import 'package:equatable/equatable.dart';

import '../ui/home_page.dart';

abstract class MenuState extends Equatable{}

class MenuStateInital extends MenuState{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class MenuStateLoading extends MenuState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class MenuStateLoaded extends MenuState{

  List<MonAn> listMenu = monan;
  MenuStateLoaded(this.listMenu);

  @override
  // TODO: implement props
  List<Object?> get props => [listMenu];

}

class MenuStateError extends MenuState{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

