import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/screens/start_wars_data_details.dart';
import 'package:star_wars_fan_app/modules/common/utilities/star_wars_data_field.dart';
import 'package:star_wars_fan_app/modules/common/utilities/string_trimmer.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';
import 'package:star_wars_fan_app/modules/people/store/people_store.dart';
import 'package:star_wars_fan_app/modules/vehicles/constants/vehicles_strings.dart';
import 'package:star_wars_fan_app/modules/vehicles/store/vehicles_store.dart';

class VehicleDataCard extends StatelessWidget {
  VehicleDataCard({
    super.key,
    this.index,
  });
  final int? index;

  @override
  Widget build(BuildContext context) {
    final dataVehicle = Provider.of<VehicleStore>(context, listen: false)
        .getVehicleByIndex(index!);
    findFilms() {
      for (var i = 0; i < dataVehicle.films!.length; i++) {
        return StringTrimmer().trimmer(dataVehicle.films![i]);
      }
    }

    findPeople() {
      for (var i = 0; i < dataVehicle.pilots!.length; i++) {
        return StringTrimmer().trimmer(dataVehicle.films![i]);
      }
      return 1;
    }

    findFilms();
    findPeople();
    final dataFilms = Provider.of<FilmsStore>(context, listen: false)
        .getFilmsByIndex(findFilms() - 1);

    final dataPeople = Provider.of<PeopleStore>(context, listen: false)
        .getPeopleByIndex(findPeople() - 1);
    return InkWell(
      onTap: () => {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (BuildContext context) => StartWarsDataDetails(
              name: dataVehicle.name,
              model: dataVehicle.model,
              manufacturer: dataVehicle.manufacturer,
              costInCredits: dataVehicle.costInCredits,
              length: dataVehicle.length,
              maxAtmospheringSpeed: dataVehicle.maxAtmospheringSpeed,
              crew: dataVehicle.crew,
              passengers: dataVehicle.passengers,
              cargoCapacity: dataVehicle.cargoCapacity,
              consumables: dataVehicle.consumables,
              vehicleClass: dataVehicle.vehicleClass,
              pilots: dataPeople.name,
              films: dataFilms.title,
            ),
          ),
        ),
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Card(
          elevation: 8.0,
          child: Column(
            children: [
              StarWardsDataField()
                  .filledData(dataVehicle.name, VehiclesStrings.nameDataField),
              StarWardsDataField().filledData(
                  dataVehicle.model, VehiclesStrings.modelDataField),
              StarWardsDataField().filledData(dataVehicle.manufacturer,
                  VehiclesStrings.manufacturerDataField),
              StarWardsDataField().filledData(dataVehicle.costInCredits,
                  VehiclesStrings.costInCreditsDataField),
              StarWardsDataField().filledData(
                  dataVehicle.length, VehiclesStrings.lengthDataField),
              StarWardsDataField().filledData(dataVehicle.maxAtmospheringSpeed,
                  VehiclesStrings.maxAtmospheringSpeedDateDataField),
              StarWardsDataField()
                  .filledData(dataVehicle.crew, VehiclesStrings.crewDataField),
              StarWardsDataField().filledData(
                  dataVehicle.passengers, VehiclesStrings.passengersDataField),
              StarWardsDataField().filledData(dataVehicle.cargoCapacity,
                  VehiclesStrings.cargoCapacityDataField),
              StarWardsDataField().filledData(dataVehicle.consumables,
                  VehiclesStrings.consumablesDataField),
              StarWardsDataField().filledData(dataVehicle.vehicleClass,
                  VehiclesStrings.vehicleClassDataField),
              StarWardsDataField().filledData(
                  dataVehicle.pilots != null && dataVehicle.pilots!.isNotEmpty
                      ? dataPeople.name
                      : null,
                  VehiclesStrings.pilotsDataField),
              StarWardsDataField().filledData(
                  dataVehicle.films != null && dataVehicle.films!.isNotEmpty
                      ? dataFilms.title!
                      : null,
                  VehiclesStrings.filmsDataField),
            ],
          ),
        ),
      ),
    );
  }
}
