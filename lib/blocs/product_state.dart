import 'package:clickpalmtask2/models/product_model.dart';
import 'package:equatable/equatable.dart';

// abstract class ProductState extends Equatable {
//   const ProductState();
// }

// class ProductLoading extends ProductState {
//   @override
//   List<Object> get props => [];
// }

// class ProductLoaded extends ProductState {
//   final List<Product> products;
//   final List<Product> filteredProducts;

//   const ProductLoaded(this.products, this.filteredProducts, );
//   @override
//   List<Object> get props => [products, filteredProducts];
// }

// class ProductError extends ProductState {
//   final String message;
//   const ProductError(this.message);
//   @override
//   List<Object> get props => [message];
// }

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> filteredProducts;

  const ProductLoaded(this.products, this.filteredProducts);
  
  @override
  List<Object> get props => [products, filteredProducts];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);
  
  @override
  List<Object> get props => [message];
}

class ProductStart extends ProductState {
  final String message;

  const ProductStart(this.message);
  
  @override
  List<Object> get props => [message];
}