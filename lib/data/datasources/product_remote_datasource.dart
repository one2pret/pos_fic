import 'package:dartz/dartz.dart';
import 'package:pos_fic/core/constants/variables.dart';
import 'package:pos_fic/data/datasources/auth_local_datasource.dart';
import 'package:pos_fic/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http
        .get(Uri.parse('${Variables.baseUrl}/api/products'), headers: {
      'Authorization': "Bearer ${authData.token}",
    });

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
