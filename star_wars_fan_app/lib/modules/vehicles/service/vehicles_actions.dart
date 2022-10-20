import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/vehicles/models/vehicles_model.dart';
import 'package:star_wars_fan_app/modules/vehicles/service/vehicles_api.dart';
import 'package:star_wars_fan_app/modules/vehicles/store/vehicles_store.dart';

class VehicleActions {
  late VehicleApi vehicleApi;

  late VehicleStore vehicleStore;

  late BuildContext context;

  VehicleActions(BuildContext context) {
    context = context;
    vehicleApi = VehicleApi();
    vehicleStore = Provider.of<VehicleStore>(context, listen: false);
  }

  Future<List<VehicleModel>> fetchVehicles() async {
    final vehicleRes = await vehicleApi.getVehicles();

    if (vehicleRes.isSuccessful!) {
      vehicleStore.setVehicles(vehicleRes.data!);
      return vehicleRes.data!;
    } else {
      return [];
    }
  }

  Future<List<VehicleModel>> fetchMoreVehicles(int? page) async {
    final vehicleRes = await vehicleApi.getMoreVehicles(page).then((response) {
      vehicleStore.page = vehicleStore.page + 1;
    });

    if (vehicleRes.isSuccessful!) {
      vehicleStore.addVehiclesToList(vehicleRes.data!);
      return vehicleRes.data!;
    } else {
      return [];
    }
  }
}
