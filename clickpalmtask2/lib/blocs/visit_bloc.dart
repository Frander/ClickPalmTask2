import 'package:clickpalmtask2/blocs/visit_event.dart';
import 'package:clickpalmtask2/blocs/visit_state.dart';
import 'package:clickpalmtask2/repositories/visit_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final VisitRepository repository;

  VisitBloc({required this.repository}) : super(VisitInitial()) {
    on<LoadVisits>(_onLoadVisits);
  }

  Future<void> _onLoadVisits(LoadVisits event, Emitter<VisitState> emit) async {
    emit(VisitLoading());
    try {
      final visits = await repository.getVisits(event.idProduct);
      emit(VisitLoaded(visits));
    } catch (e) {
      emit(VisitError(e.toString()));
    }
  }
}