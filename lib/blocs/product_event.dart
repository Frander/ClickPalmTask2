import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProducts extends ProductEvent {
  final String typeSearch;
  final String textSearch1;
  final String textSearch2;
  final String idCompany;

  const LoadProducts({
    required this.typeSearch,
    required this.textSearch1,
    required this.textSearch2,
    required this.idCompany,
  });

  @override
  List<Object> get props => [typeSearch, textSearch1, textSearch2, idCompany];
}

class FilterProducts extends ProductEvent {
  final String rfid;

  const FilterProducts({required this.rfid});
  @override
  List<Object> get props => [rfid];
}