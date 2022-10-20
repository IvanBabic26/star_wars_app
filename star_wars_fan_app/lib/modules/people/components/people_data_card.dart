import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/screens/start_wars_data_details.dart';
import 'package:star_wars_fan_app/modules/common/utilities/star_wars_data_field.dart';
import 'package:star_wars_fan_app/modules/common/utilities/string_trimmer.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';
import 'package:star_wars_fan_app/modules/people/store/people_store.dart';
import 'package:star_wars_fan_app/modules/planets/store/planets_store.dart';
import 'package:star_wars_fan_app/modules/species/store/species_store.dart';
import 'package:star_wars_fan_app/modules/people/constants/people_strings.dart';
import 'package:star_wars_fan_app/modules/starships/store/starships_store.dart';
import 'package:star_wars_fan_app/modules/vehicles/store/vehicles_store.dart';

class PeopleDataCard extends StatelessWidget {
  PeopleDataCard({
    super.key,
    this.index,
  });
  final int? index;

  @override
  Widget build(BuildContext context) {
    final dataPeople = Provider.of<PeopleStore>(context, listen: false)
        .getPeopleByIndex(index!);
    findFilms() {
      for (var i = 0; i < dataPeople.films!.length; i++) {
        return StringTrimmer().trimmer(dataPeople.films![i]);
      }
    }

    findSpecies() {
      for (var i = 0; i < dataPeople.species!.length; i++) {
        return StringTrimmer().trimmer(dataPeople.species![i]);
      }
      if (dataPeople.species!.isEmpty) {
        return 0;
      }
      return 1;
    }

    findVehicles() {
      for (var i = 0; i < dataPeople.vehicles!.length; i++) {
        return StringTrimmer().trimmer(dataPeople.vehicles![i]);
      }

      return 1;
    }

    findStarships() {
      for (var i = 0; i < dataPeople.starships!.length; i++) {
        return StringTrimmer().trimmer(dataPeople.starships![i]);
      }
      return 1;
    }

    findPlanets() {
      return StringTrimmer().trimmer(dataPeople.homeworld!);
    }

    findFilms();
    findStarships();
    findSpecies();
    findVehicles();
    findPlanets();
    final dataFilms = Provider.of<FilmsStore>(context, listen: false)
        .getFilmsByIndex(findFilms() - 1);
    final dataSpecies = Provider.of<SpeciesStore>(context, listen: false)
        .getSpeciesByIndex(findSpecies());
    final dataStarships = Provider.of<StarshipStore>(context, listen: false)
        .getStarshipByIndex(findStarships());
    final dataVehicles = Provider.of<VehicleStore>(context, listen: false)
        .getVehicleByIndex(findVehicles());
    final dataPlanets = Provider.of<PlanetsStore>(context, listen: false)
        .getPlanetsByIndex(findPlanets());
    return InkWell(
      onTap: () => {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (BuildContext context) => StartWarsDataDetails(
              name: dataPeople.name,
              mass: dataPeople.mass,
              hairColor: dataPeople.hairColor,
              skinColor: dataPeople.skinColor,
              eyeColor: dataPeople.eyeColor,
              birthYear: dataPeople.birthYear,
              gender: dataPeople.gender,
              homeWorld: dataPlanets.name,
              films: dataFilms.title,
              species: dataSpecies.name,
              vehicles: dataVehicles.name,
              starships: dataStarships.name,
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
                  .filledData(dataPeople.name, PeopleStrings.nameDataField),
              StarWardsDataField()
                  .filledData(dataPeople.height, PeopleStrings.heightDataField),
              StarWardsDataField().filledData(
                  dataPeople.mass, PeopleStrings.massCrawlDataField),
              StarWardsDataField().filledData(
                  dataPeople.hairColor, PeopleStrings.hairColorDataField),
              StarWardsDataField().filledData(
                  dataPeople.skinColor, PeopleStrings.skinColorDataField),
              StarWardsDataField().filledData(
                  dataPeople.eyeColor, PeopleStrings.eyeColorDateDataField),
              StarWardsDataField().filledData(
                  dataPeople.birthYear, PeopleStrings.birthYearDataField),
              StarWardsDataField()
                  .filledData(dataPeople.gender, PeopleStrings.genderDataField),
              StarWardsDataField().filledData(
                  dataPlanets.name, PeopleStrings.homeWorldDataField),
              StarWardsDataField().filledData(
                  dataPeople.films != null && dataPeople.films!.isNotEmpty
                      ? dataFilms.title
                      : null,
                  PeopleStrings.filmsDataField),
              StarWardsDataField().filledData(
                  dataPeople.species != null && dataPeople.species!.isNotEmpty
                      ? dataSpecies.name
                      : null,
                  PeopleStrings.speciesDataField),
              StarWardsDataField().filledData(
                  dataPeople.vehicles != null && dataPeople.vehicles!.isNotEmpty
                      ? dataVehicles.name
                      : null,
                  PeopleStrings.vehiclesDataField),
              StarWardsDataField().filledData(
                  dataPeople.starships != null &&
                          dataPeople.starships!.isNotEmpty
                      ? dataStarships.name
                      : null,
                  PeopleStrings.starshipsDataField),
            ],
          ),
        ),
      ),
    );
  }
}
