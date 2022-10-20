import 'package:flutter/foundation.dart';
import 'package:star_wars_fan_app/modules/vehicles/models/vehicles_model.dart';
import 'package:star_wars_fan_app/modules/vehicles/service/vehicles_api.dart';

class VehicleStore extends ChangeNotifier {
  late bool _hasNextPage = true;

  bool get hasNextPage => _hasNextPage;

  setNextPage(bool loading) {
    _hasNextPage = loading;
    notifyListeners();
  }

  /// Used to display loading indicators when _initFetch function is running
  late bool _isFirstLoadRunning = false;

  bool get isFirstLoadRunning => _isFirstLoadRunning;

  setFirstLoading(bool loading) {
    _isFirstLoadRunning = loading;
    notifyListeners();
  }

  /// Used to display loading indicators when _fetchMore function is running
  late bool _isLoadMoreRunning = false;

  bool get isLoadMoreRunning => _isLoadMoreRunning;

  setMoreLoading(bool loading) {
    _isLoadMoreRunning = loading;
    notifyListeners();
  }

  List<VehicleModel>? vehiclesList = [];

  List<VehicleModel>? get vehicleData => vehiclesList;

  late int _page = 2;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  void setVehicles(List<VehicleModel>? vehicleData) {
    vehiclesList = vehicleData;
    notifyListeners();
  }

  VehicleModel getVehicleByIndex(int index) => vehiclesList![index];

  Future<void> fetchMoreVehicles() async {
    await VehicleApi()
        .getMoreVehicles(
      _page,
    )
        .then((response) {
      if (response.isSuccessful!) {
        _page = _page + 1;
        print(_page.toString());
        addVehiclesToList(response.data!);
        setNextPage(true);
      } else {
        setNextPage(false);
      }
    });
    notifyListeners();
  }

  void addVehiclesToList(List<VehicleModel> vehicleData) {
    vehiclesList!.addAll(vehicleData);
    notifyListeners();
  }
}
