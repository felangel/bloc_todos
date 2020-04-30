part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class HomeTabChanged extends HomeEvent {
  const HomeTabChanged(this.index);

  final int index;
}
