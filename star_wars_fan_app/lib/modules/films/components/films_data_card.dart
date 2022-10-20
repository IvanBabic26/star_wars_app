import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/screens/start_wars_data_details.dart';
import 'package:star_wars_fan_app/modules/common/utilities/star_wars_data_field.dart';
import 'package:star_wars_fan_app/modules/common/utilities/string_trimmer.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';
import 'package:star_wars_fan_app/modules/people/store/people_store.dart';
import 'package:star_wars_fan_app/modules/planets/store/planets_store.dart';
import 'package:star_wars_fan_app/modules/species/store/species_store.dart';
import 'package:star_wars_fan_app/modules/films/constants/films_strings.dart';
import 'package:star_wars_fan_app/modules/starships/store/starships_store.dart';
import 'package:star_wars_fan_app/modules/vehicles/store/vehicles_store.dart';

class FilmsDataCard extends StatelessWidget {
  FilmsDataCard({
    super.key,
    this.index,
  });
  final int? index;

  @override
  Widget build(BuildContext context) {
    final dataFilms =
        Provider.of<FilmsStore>(context, listen: false).getFilmsByIndex(index!);
    findPeople() {
      for (var i = 0; i < dataFilms.characters!.length; i++) {
        return StringTrimmer().trimmer(dataFilms.characters![i]);
      }
    }

    findSpecies() {
      for (var i = 0; i < dataFilms.species!.length; i++) {
        return StringTrimmer().trimmer(dataFilms.species![i]);
      }
      return 1;
    }

    findVehicles() {
      for (var i = 0; i < dataFilms.vehicles!.length; i++) {
        return StringTrimmer().trimmer(dataFilms.vehicles![i]);
      }
    }

    findStarships() {
      for (var i = 0; i < dataFilms.starships!.length; i++) {
        return StringTrimmer().trimmer(dataFilms.starships![i]);
      }
      return 1;
    }

    findPlanets() {
      for (var i = 0; i < dataFilms.planets!.length; i++) {
        return StringTrimmer().trimmer(dataFilms.planets![i]);
      }
    }

    findStarships();
    findSpecies();
    findVehicles();
    findPlanets();
    findPeople();

    final dataSpecies = Provider.of<SpeciesStore>(context, listen: false)
        .getSpeciesByIndex(findSpecies() - 1);
    final dataStarships = Provider.of<StarshipStore>(context, listen: false)
        .getStarshipByIndex(findStarships() - 1);
    final dataVehicles = Provider.of<VehicleStore>(context, listen: false)
        .getVehicleByIndex(findVehicles() - 1);
    final dataPlanets = Provider.of<PlanetsStore>(context, listen: false)
        .getPlanetsByIndex(findPlanets() - 1);
    final dataPeople = Provider.of<PeopleStore>(context, listen: false)
        .getPeopleByIndex(findPeople() - 1);
    return InkWell(
      onTap: () => {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (BuildContext context) => StartWarsDataDetails(
              title: dataFilms.title,
              episodeId: dataFilms.episodeId,
              openingCrawl: dataFilms.openingCrawl,
              director: dataFilms.director,
              producer: dataFilms.producer,
              releaseDate: dataFilms.releaseDate,
              characters: dataPeople.name,
              starships: dataStarships.name,
              vehicles: dataVehicles.name,
              species: dataSpecies.name,
              planets: dataPlanets.name,
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
                  .filledData(dataFilms.title, FilmsStrings.titleDataField),
              StarWardsDataField().filledData(dataFilms.episodeId.toString(),
                  FilmsStrings.episodeIdDataField),
              StarWardsDataField().filledData(
                  dataFilms.openingCrawl, FilmsStrings.openingCrawlDataField),
              StarWardsDataField().filledData(
                  dataFilms.director, FilmsStrings.directorDataField),
              StarWardsDataField().filledData(
                  dataFilms.producer, FilmsStrings.producerDataField),
              StarWardsDataField().filledData(
                  dataFilms.releaseDate, FilmsStrings.releaseDateDataField),
              StarWardsDataField().filledData(
                  dataFilms.characters != null &&
                          dataFilms.characters!.isNotEmpty
                      ? dataPeople.name
                      : null,
                  FilmsStrings.charactersDataField),
              StarWardsDataField().filledData(
                  dataFilms.starships != null && dataFilms.starships!.isNotEmpty
                      ? dataStarships.name
                      : null,
                  FilmsStrings.starshipsDataField),
              StarWardsDataField().filledData(
                  dataFilms.vehicles != null && dataFilms.vehicles!.isNotEmpty
                      ? dataVehicles.name
                      : null,
                  FilmsStrings.vehiclesDataField),
              StarWardsDataField().filledData(
                  dataFilms.species != null && dataFilms.species!.isNotEmpty
                      ? dataSpecies.name
                      : null,
                  FilmsStrings.speciesDataField),
              StarWardsDataField().filledData(
                  dataFilms.planets != null && dataFilms.planets!.isNotEmpty
                      ? dataPlanets.name
                      : null,
                  FilmsStrings.speciesDataField),
            ],
          ),
        ),
      ),
    );
  }
}
