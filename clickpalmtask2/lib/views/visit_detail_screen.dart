import 'package:clickpalmtask2/blocs/visit_bloc.dart';
import 'package:clickpalmtask2/blocs/visit_event.dart';
import 'package:clickpalmtask2/blocs/visit_state.dart';
import 'package:clickpalmtask2/repositories/visit_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class VisitDetailScreen extends StatelessWidget {
  final int idProduct;

  const VisitDetailScreen({super.key, required this.idProduct});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitBloc(
        repository: VisitRepository(),
      )..add(LoadVisits(idProduct)),
      child: Scaffold(
        appBar: AppBar(title: Text('Visitas del Producto $idProduct')),
        body: _buildVisitsList(),
      ),
    );
  }

  Widget _buildVisitsList() {
    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) {
        if (state is VisitLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is VisitError) {
          return Center(child: Text(state.message));
        }
        if (state is VisitLoaded) {
          return ListView.builder(
            itemCount: state.visits.length,
            itemBuilder: (context, index) {
              final visit = state.visits[index];
              final parsearDate = DateTime.parse(visit.createdAt);
              final dateFormat = DateFormat('dd/MM/yyyy').format(parsearDate);              return ListTile(
                title: Text(visit.idVisit.toString()),
                subtitle: Text('Fecha: ${dateFormat} description: ${visit.descriptionVisit}'),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}