import 'dart:convert';

import 'package:http/http.dart';

import '../models/models.dart';
import '../utils/constants.dart';

class ProductRepository {
  Future<Course> findByName(String name) async {
    final response = await get(Uri.parse("$pathToUtl/products?name=$name"));
    
    if(response.statusCode != 200 ){
      throw Exception();
    }

    final responseData = jsonDecode(response.body);
    if(responseData.isEmpty){
      throw Exception("Produto não encontrado!!");
    }
    return Course.fromMap(responseData.first);
  }
}
