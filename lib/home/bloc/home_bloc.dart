import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todos/home/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => const HomeState(activeTab: HomeTab.todos);

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeTabChanged) {
      yield HomeState(activeTab: HomeTab.values[event.index]);
    }
  }
}
