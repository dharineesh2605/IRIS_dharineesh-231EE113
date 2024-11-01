import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends HomeEvent {}

class LoadUsersForAdmin extends HomeEvent{}



