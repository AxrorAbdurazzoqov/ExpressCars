import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {}

class OnNavbarIndexChangedEvent extends NavigationEvent {
  final int index;

  OnNavbarIndexChangedEvent({required this.index});
  @override
  List<Object?> get props => [
        index
      ];
}
