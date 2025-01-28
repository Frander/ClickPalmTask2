import 'package:clickpalmtask2/models/visit_model.dart';
import 'package:dio/dio.dart';

class VisitRepository {
  final Dio _dio = Dio();

  Future<List<Visit>> getVisits(int idProduct) async {
    final response = await _dio.get(
      'https://api.clickpalm.com/Visits/filters',
      queryParameters: {
        'Type_search': 'ID PRODUCT',
        'Text_search1': idProduct.toString(),
        'Text_search2': '',
        'Id_company': '',
      },
    );

    return (response.data as List)
        .map((visit) => Visit.fromJson(visit))
        .toList();
  }
}