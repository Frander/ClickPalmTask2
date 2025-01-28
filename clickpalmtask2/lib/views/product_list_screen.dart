import 'package:clickpalmtask2/blocs/product_bloc.dart';
import 'package:clickpalmtask2/blocs/product_event.dart';
import 'package:clickpalmtask2/blocs/product_state.dart';
import 'package:clickpalmtask2/repositories/product_repository.dart';
import 'package:clickpalmtask2/views/visit_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _formKey = GlobalKey<FormState>();
  String _typeSearch = 'ID COMPANY PAGINATION';
  String _textSearch1 = '10';
  String _textSearch2 = '1';
  String _idCompany = '1';

  @override
  Widget build(BuildContext context) {
    //_submitSearch(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: Column(
        children: [
          _buildSearchForm(),
          _buildFilters(),
          Expanded(child: _buildProductTable()),
        ],
      ),
    );
  }

  Widget _buildSearchForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _typeSearch,
              items: const [
                DropdownMenuItem(value: 'ID COMPANY PAGINATION', child: Text('ID COMPANY PAGINATION')),
              ],
              onChanged: (value) => setState(() => _typeSearch = value!),
              decoration: const InputDecoration(labelText: 'Tipo de Búsqueda'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Texto de Búsqueda 1'),
              onChanged: (value) => _textSearch1 = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Texto de Búsqueda 2'),
              onChanged: (value) => _textSearch2 = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'ID Compañía'),
              onChanged: (value) => _idCompany = value,
              validator: (value) => value!.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _submitSearch(context),
              child: const Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitSearch(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ProductBloc>().add(
            LoadProducts(
              typeSearch: _typeSearch,
              textSearch1: _textSearch1,
              textSearch2: _textSearch2,
              idCompany: _idCompany,
            ),
          );
    }
  }

  Widget _buildProductTable() {
  return BlocBuilder<ProductBloc, ProductState>(
    builder: (context, state) {
      if (state is ProductStart) {
        return Center(child: Text(state.message));
      }
      if (state is ProductLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is ProductError) {
        return Center(child: Text(state.message));
      }
      if (state is ProductLoaded) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Id Product')),
                DataColumn(label: Text('Id Headquarters')),
                DataColumn(label: Text('RFID')),
                DataColumn(label: Text('State Product')),
                DataColumn(label: Text('Desc')),
                DataColumn(label: Text('Line')),
                DataColumn(label: Text('Palm')),
              ],
              rows: state.filteredProducts.map((product) {
                return DataRow(
                  onSelectChanged: (_) => _navigateToDetail(context, product.idProduct),
                  cells: [
                    DataCell(Text(product.idProduct.toString())),
                    DataCell(Text(product.idHeadquarters.toString())),
                    DataCell(Text(product.rfid)),
                    DataCell(Text(product.stateProduct)),
                    DataCell(Text(product.description)),
                    DataCell(Text(product.line.toString())),
                    DataCell(Text(product.palm.toString())),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      }
      return const Center(child: Text('Realice una búsqueda para ver los resultados'));
    },
  );
}


  Widget _buildFilters() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<ProductBloc>(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Buscar por RFID'),
                onChanged: (value) => bloc.add(FilterProducts(
                  rfid: value,
                )),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToDetail(BuildContext context, int idProduct) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VisitDetailScreen(idProduct: idProduct),
      ),
    );
  }
}