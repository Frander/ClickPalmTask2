import 'package:clickpalmtask2/models/visit_model.dart';
import 'package:equatable/equatable.dart';

abstract class VisitState extends Equatable {
  const VisitState();
}

class VisitInitial extends VisitState {
  @override
  List<Object> get props => [];
}

class VisitLoading extends VisitState {
  @override
  List<Object> get props => [];
}

class VisitLoaded extends VisitState {
  final List<Visit> visits;

  const VisitLoaded(this.visits);
  
  @override
  List<Object> get props => [visits];
}

class VisitError extends VisitState {
  final String message;

  const VisitError(this.message);
  
  @override
  List<Object> get props => [message];
}