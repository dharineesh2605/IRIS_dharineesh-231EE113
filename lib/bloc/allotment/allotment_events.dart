import 'package:equatable/equatable.dart';

abstract class AllotmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadHostels extends AllotmentEvent {}



class H2RegisterEvent extends AllotmentEvent {
  final String hostelId;
  final String wing;
  final String room;

  H2RegisterEvent({required this.hostelId, required this.wing, required this.room});

  @override
  List<Object> get props => [hostelId, wing, room];
}
class ChangeHostelEvent extends AllotmentEvent {
  final String currentHostelId;
  final String newHostelId;
  final String newWing;
  final String newRoom;

  ChangeHostelEvent(this.currentHostelId, this.newHostelId, this.newWing, this.newRoom);

  @override
  List<Object> get props => [currentHostelId, newHostelId, newWing, newRoom];
}

