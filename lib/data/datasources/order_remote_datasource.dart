import "package:http/http.dart" as http;
import "package:pos_fic/core/constants/variables.dart";
import "package:pos_fic/data/datasources/auth_local_datasource.dart";
import "package:pos_fic/data/models/request/order_request_model.dart";

class OrderRemoteDatasource {
  Future<bool> sendOrder(OrderRequestModel requestModel) async {
    final url = Uri.parse('${Variables.baseUrl}/api/orders');
    final authData = await AuthLocalDatasource().getAuthData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    print(requestModel.toJson());
    final response =
        await http.post(url, headers: headers, body: requestModel.toJson());
    print(response);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
