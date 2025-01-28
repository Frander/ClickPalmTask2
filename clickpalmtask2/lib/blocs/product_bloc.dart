import 'package:clickpalmtask2/blocs/product_event.dart';
import 'package:clickpalmtask2/blocs/product_state.dart';
import 'package:clickpalmtask2/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductStart("Ingrese búsqueda")) {
    on<LoadProducts>(_onLoadProducts);
    on<FilterProducts>(_onFilterProducts);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());
      final products = await repository.getProducts(
        Type_search: event.typeSearch,
        Text_search1: event.textSearch1,
        Text_search2: event.textSearch2,
        Id_company: event.idCompany,
      );
      emit(ProductLoaded(products, products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onFilterProducts(FilterProducts event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final filtered = currentState.products.where((product) {
        final rfidMatch = product.rfid.toLowerCase().contains(event.rfid.toLowerCase());
        return rfidMatch;
      }).toList();

      
      emit(ProductLoaded(currentState.products, filtered));
    }
  }
}

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final ProductRepository repository;
//   final String idCompany;

//   ProductBloc({required this.repository, required this.idCompany})
//       : super(ProductLoading()) {
//     on<LoadProducts>(_onLoadProducts);
//     on<FilterProducts>(_onFilterProducts);
//   }

//   void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
//     try {
//       final products = await repository.getProducts(idCompany: idCompany);
//       emit(ProductLoaded(products, products));
//     } catch (e) {
//       emit(ProductError(e.toString()));
//     }
//   }

//   void _onFilterProducts(FilterProducts event, Emitter<ProductState> emit) {
//     if (state is ProductLoaded) {
//       final currentState = state as ProductLoaded;
//       final filtered = currentState.products.where((product) {
//         final rfidMatch = product.rfid.toLowerCase().contains(event.rfid.toLowerCase());
//         final descMatch = product.description.toLowerCase().contains(event.description.toLowerCase());
//         return rfidMatch && descMatch;
//       }).toList();
      
//       emit(ProductLoaded(currentState.products, filtered));
//     }
//   }
// }