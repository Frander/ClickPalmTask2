import 'package:equatable/equatable.dart';

abstract class VisitEvent extends Equatable {
  const VisitEvent();
}

class LoadVisits extends VisitEvent {
  final int idProduct;

  const LoadVisits(this.idProduct);
  
  @override
  List<Object> get props => [idProduct];
}