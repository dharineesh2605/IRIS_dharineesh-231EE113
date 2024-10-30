import 'package:equatable/equatable.dart';

abstract class AllotmentState extends Equatable {
  @override
  List<Object> get props => [];
}

class AllotmentInitial extends AllotmentState {}

class AllotmentLoading extends AllotmentState {}

class AllotmentLoaded extends AllotmentState {
  final List<Map<String, dynamic>> hostels;

  AllotmentLoaded(this.hostels);

  @override
  List<Object> get props => [hostels];
}

class AllotmentError extends AllotmentState {
  final String message;

  AllotmentError(this.message);

  @override
  List<Object> get props => [message];
}




