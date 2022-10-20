import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/screens/start_wars_data_details.dart';
import 'package:star_wars_fan_app/modules/common/utilities/star_wars_data_field.dart';
import 'package:star_wars_fan_app/modules/common/utilities/string_trimmer.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';
import 'package:star_wars_fan_app/modules/people/store/people_store.dart';
import 'package:star_wars_fan_app/modules/planets/store/planets_store.dart';
import 'package:star_wars_fan_app/modules/species/store/species_store.dart';
import 'package:star_wars_fan_app/modules/species/constants/species_strings.dart';

class SpeciesDataCard extends StatelessWidget {
  SpeciesDataCard({
    super.key,
    this.index,
  });
  final int? index;

  @override
  Widget build(BuildContext context) {
    final dataSpecies = Provider.of<SpeciesStore>(context, listen: false)
        .getSpeciesByIndex(index!);
    findFilms() {
      for (var i = 0; i < dataSpecies.films!.length; i++) {
        return StringTrimmer().trimmer(dataSpecies.films![i]);
      }
    }

    findPlanets() {
      if (dataSpecies.homeworld != null) {
        return StringTrimmer().trimmer(dataSpecies.homeworld!);
      } else {
        return 0;
      }
    }

    findFilms();
    findPlanets();
    final dataFilms = Provider.of<FilmsStore>(context, listen: false)
        .getFilmsByIndex(findFilms() - 1);
    final dataPeople = Provider.of<PeopleStore>(context, listen: false)
        .getPeopleByIndex(findFilms() - 1);
    final dataPlanets = Provider.of<PlanetsStore>(context, listen: false)
        .getPlanetsByIndex(findPlanets());
    return InkWell(
      onTap: () => {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (BuildContext context) => StartWarsDataDetails(
              name: dataSpecies.name,
              classification: dataSpecies.classification,
              designation: dataSpecies.designation,
              hairColorSpecies: dataSpecies.hairColors,
              skinColorSpecies: dataSpecies.skinColors,
              eyeColorSpecies: dataSpecies.eyeColors,
              averageLifespan: dataSpecies.averageLifespan,
              homeWorldSpecies: dataPlanets.name,
              language: dataSpecies.language,
              people: dataPeople.name,
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
                  .filledData(dataSpecies.name, SpeciesStrings.nameDataField),
              StarWardsDataField().filledData(dataSpecies.classification,
                  SpeciesStrings.classificationDataField),
              StarWardsDataField().filledData(
                  dataSpecies.designation, SpeciesStrings.designationDataField),
              StarWardsDataField().filledData(
                  dataSpecies.hairColors, SpeciesStrings.hairColorsDataField),
              StarWardsDataField().filledData(
                  dataSpecies.skinColors, SpeciesStrings.skinColorsDataField),
              StarWardsDataField().filledData(
                  dataSpecies.eyeColors, SpeciesStrings.eyeColorsDateDataField),
              StarWardsDataField().filledData(dataSpecies.averageLifespan,
                  SpeciesStrings.averageLifespanDataField),
              StarWardsDataField().filledData(
                  dataPlanets.name, SpeciesStrings.homeWorldDataField),
              StarWardsDataField().filledData(
                  dataSpecies.language, SpeciesStrings.languageDataField),
              StarWardsDataField().filledData(
                  dataSpecies.people != null && dataSpecies.people!.isNotEmpty
                      ? dataPeople.name
                      : null,
                  SpeciesStrings.peopleDataField),
              StarWardsDataField().filledData(
                  dataSpecies.films != null && dataSpecies.films!.isNotEmpty
                      ? dataFilms.title
                      : null,
                  SpeciesStrings.filmsDataField),
            ],
          ),
        ),
      ),
    );
  }
}
