import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/screens/start_wars_data_details.dart';
import 'package:star_wars_fan_app/modules/common/utilities/star_wars_data_field.dart';
import 'package:star_wars_fan_app/modules/common/utilities/string_trimmer.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';
import 'package:star_wars_fan_app/modules/people/store/people_store.dart';
import 'package:star_wars_fan_app/modules/starships/store/starships_store.dart';
import 'package:star_wars_fan_app/modules/starships/constants/starships_strings.dart';

class StarshipDataCard extends StatelessWidget {
  StarshipDataCard({
    super.key,
    this.index,
  });
  final int? index;

  @override
  Widget build(BuildContext context) {
    final dataStarships = Provider.of<StarshipStore>(context, listen: false)
        .getStarshipByIndex(index!);
    findFilms() {
      for (var i = 0; i < dataStarships.films!.length; i++) {
        return StringTrimmer().trimmer(dataStarships.films![i]);
      }
    }

    findFilms();
    final dataFilms = Provider.of<FilmsStore>(context, listen: false)
        .getFilmsByIndex(findFilms() - 1);
    final dataPeople = Provider.of<PeopleStore>(context, listen: false)
        .getPeopleByIndex(findFilms() - 1);
    return InkWell(
      onTap: () => {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (BuildContext context) => StartWarsDataDetails(
              name: dataStarships.name,
              model: dataStarships.model,
              manufacturer: dataStarships.manufacturer,
              costInCredits: dataStarships.costInCredits,
              length: dataStarships.length,
              maxAtmospheringSpeed: dataStarships.maxAtmospheringSpeed,
              crew: dataStarships.crew,
              passengers: dataStarships.passengers,
              cargoCapacity: dataStarships.cargoCapacity,
              consumables: dataStarships.consumables,
              hyperdriveRating: dataStarships.hyperdriveRating,
              mGLT: dataStarships.mGLT,
              starshipClass: dataStarships.starshipClass,
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
              StarWardsDataField().filledData(
                  dataStarships.name, StarshipsStrings.nameDataField),
              StarWardsDataField().filledData(
                  dataStarships.model, StarshipsStrings.modelDataField),
              StarWardsDataField().filledData(dataStarships.manufacturer,
                  StarshipsStrings.manufacturerDataField),
              StarWardsDataField().filledData(dataStarships.costInCredits,
                  StarshipsStrings.costInCreditsDataField),
              StarWardsDataField().filledData(
                  dataStarships.length, StarshipsStrings.lengthDataField),
              StarWardsDataField().filledData(
                  dataStarships.maxAtmospheringSpeed,
                  StarshipsStrings.maxAtmospheringSpeedDateDataField),
              StarWardsDataField().filledData(
                  dataStarships.crew, StarshipsStrings.crewDataField),
              StarWardsDataField().filledData(dataStarships.passengers,
                  StarshipsStrings.passengersDataField),
              StarWardsDataField().filledData(dataStarships.cargoCapacity,
                  StarshipsStrings.cargoCapacityDataField),
              StarWardsDataField().filledData(dataStarships.consumables,
                  StarshipsStrings.consumablesDataField),
              StarWardsDataField().filledData(dataStarships.hyperdriveRating,
                  StarshipsStrings.hyperDriveRatingDataField),
              StarWardsDataField().filledData(
                  dataStarships.mGLT, StarshipsStrings.mGLTDataField),
              StarWardsDataField().filledData(dataStarships.starshipClass,
                  StarshipsStrings.starshipClassDataField),
              StarWardsDataField().filledData(
                  dataStarships.pilots != null &&
                          dataStarships.pilots!.isNotEmpty
                      ? dataPeople.name
                      : null,
                  StarshipsStrings.pilotsDataField),
              StarWardsDataField().filledData(
                  dataStarships.films != null && dataStarships.films!.isNotEmpty
                      ? dataFilms.title
                      : null,
                  StarshipsStrings.filmsDataField),
            ],
          ),
        ),
      ),
    );
  }
}
