import 'dart:async';
import 'dart:convert';
import 'package:star_wars_fan_app/modules/common/utilities/http_enum.dart';
import 'package:star_wars_fan_app/modules/common/utilities/http_provider.dart';
import 'package:star_wars_fan_app/modules/species/models/species_model.dart';

class SpeciesApi {
  Future<HTTPResponse<List<SpeciesModel>>> getSpecies() async {
    final response = await (SWHttpProvider.apiRequest(Method.GET, 'species'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<SpeciesModel> species = [];
      if (data != null) {
        species = data.map((item) => SpeciesModel.fromJson(item)).toList();
      }
      return HTTPResponse<List<SpeciesModel>>(
        isSuccessful: true,
        data: species,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<SpeciesModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }

  Future<HTTPResponse<List<SpeciesModel>>> getMoreSpecies(int? page) async {
    final response =
        await (SWHttpProvider.apiRequest(Method.GET, 'species/?page=$page'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<SpeciesModel> species = [];
      if (data != null) {
        species = data.map((item) => SpeciesModel.fromJson(item)).toList();
      }
      return HTTPResponse<List<SpeciesModel>>(
        isSuccessful: true,
        data: species,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<SpeciesModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }
}
