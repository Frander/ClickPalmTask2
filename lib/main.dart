import 'package:clickpalmtask2/blocs/product_bloc.dart';
import 'package:clickpalmtask2/repositories/product_repository.dart';
import 'package:clickpalmtask2/repositories/visit_repository.dart';
import 'package:clickpalmtask2/views/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(
  MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => ProductRepository()),
      RepositoryProvider(create: (context) => VisitRepository()),
    ],
    child: MaterialApp(
      home: BlocProvider(
        create: (context) => ProductBloc(
          repository: RepositoryProvider.of<ProductRepository>(context),
        ),
        child: const ProductListScreen(),
      ),
    ),
  ),
);