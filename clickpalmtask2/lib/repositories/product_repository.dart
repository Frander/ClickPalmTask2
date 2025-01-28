import 'package:clickpalmtask2/models/product_model.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  final Dio _dio = Dio();

  Future<List<Product>> getProducts({
    required String Type_search,
    required String Text_search1,
    required String Text_search2,
    required String Id_company,
  }) async {
    final response = await _dio.get(
      'https://api.clickpalm.com/Products/filters',
      queryParameters: {
        // 'Type_search': 'ID COMPANY PAGINATION',
        // 'Text_search1': 10,
        // 'Text_search2': 1,
        // 'Id_company': 1,
        'Type_search': Type_search,
        'Text_search1': Text_search1,
        'Text_search2': Text_search2,
        'Id_company': Id_company,
      },
    );

print("test");
    return (response.data as List)
        .map((product) => Product.fromJson(product))
        .toList();
  }
}