import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Map<String, dynamic> user;
  final String currentHostelId;

  const HomeLoaded(this.user, {this.currentHostelId = ''});

  @override
  List<Object> get props => [user, currentHostelId];
}
class HomeLoadedAdmin extends HomeState{
  final List<Map<String, dynamic>> users;
  final String currentHostelId; // Add this field

  const HomeLoadedAdmin(this.users, {this.currentHostelId = ''});

  @override
  List<Object> get props => [users, currentHostelId];

}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

