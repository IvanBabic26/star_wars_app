import 'dart:async';
import 'dart:convert';
import 'package:star_wars_fan_app/modules/common/utilities/http_enum.dart';
import 'package:star_wars_fan_app/modules/common/utilities/http_provider.dart';
import 'package:star_wars_fan_app/modules/vehicles/models/vehicles_model.dart';

class VehicleApi {
  Future<HTTPResponse<List<VehicleModel>>> getVehicles() async {
    final response = await (SWHttpProvider.apiRequest(Method.GET, 'vehicles'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<VehicleModel> vehicles = [];
      if (data != null) {
        vehicles = data.map((item) => VehicleModel.fromJson(item)).toList();
      }
      return HTTPResponse<List<VehicleModel>>(
        isSuccessful: true,
        data: vehicles,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<VehicleModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }

  Future<HTTPResponse<List<VehicleModel>>> getMoreVehicles(int? page) async {
    final response =
        await (SWHttpProvider.apiRequest(Method.GET, 'vehicles/?page=$page'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<VehicleModel> vehicles = [];
      if (data != null) {
        vehicles = data.map((item) => VehicleModel.fromJson(item)).toList();
      }
      return HTTPResponse<List<VehicleModel>>(
        isSuccessful: true,
        data: vehicles,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<VehicleModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }
}
