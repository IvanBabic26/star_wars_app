import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/screens/start_wars_data_details.dart';
import 'package:star_wars_fan_app/modules/common/utilities/star_wars_data_field.dart';
import 'package:star_wars_fan_app/modules/common/utilities/string_trimmer.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';
import 'package:star_wars_fan_app/modules/planets/store/planets_store.dart';
import 'package:star_wars_fan_app/modules/planets/constants/planets_strings.dart';
import 'package:star_wars_fan_app/modules/species/store/species_store.dart';

class PlanetsDataCard extends StatelessWidget {
  PlanetsDataCard({
    super.key,
    this.index,
  });
  final int? index;

  @override
  Widget build(BuildContext context) {
    final dataPlanet = Provider.of<PlanetsStore>(context, listen: false)
        .getPlanetsByIndex(index!);
    findFilms() {
      for (var i = 0; i < dataPlanet.films!.length; i++) {
        return StringTrimmer().trimmer(dataPlanet.films![i]);
      }
      return 1;
    }

    findSpecies() {
      for (var i = 0; i < dataPlanet.residents!.length; i++) {
        return StringTrimmer().trimmer(dataPlanet.residents![i]);
      }
      return 1;
    }

    findFilms();
    final dataFilms = Provider.of<FilmsStore>(context, listen: false)
        .getFilmsByIndex(findFilms() - 1);
    final dataSpecies = Provider.of<SpeciesStore>(context, listen: false)
        .getSpeciesByIndex(findSpecies());
    return InkWell(
      onTap: () => {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (BuildContext context) => StartWarsDataDetails(
              name: dataPlanet.name,
              rotationPeriod: dataPlanet.rotationPeriod,
              orbitalPeriod: dataPlanet.orbitalPeriod,
              diameter: dataPlanet.diameter,
              classification: dataPlanet.climate,
              gravity: dataPlanet.gravity,
              terrain: dataPlanet.terrain,
              surfaceWater: dataPlanet.surfaceWater,
              population: dataPlanet.population,
              residents: dataSpecies.name,
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
                  .filledData(dataPlanet.name, PlanetsStrings.nameDataField),
              StarWardsDataField().filledData(dataPlanet.rotationPeriod,
                  PlanetsStrings.rotationPeriodField),
              StarWardsDataField().filledData(dataPlanet.orbitalPeriod,
                  PlanetsStrings.orbitalPeriodDataField),
              StarWardsDataField().filledData(
                  dataPlanet.diameter, PlanetsStrings.diameterDataField),
              StarWardsDataField().filledData(
                  dataPlanet.climate, PlanetsStrings.climateDataField),
              StarWardsDataField().filledData(
                  dataPlanet.gravity, PlanetsStrings.gravityDateDataField),
              StarWardsDataField().filledData(
                  dataPlanet.terrain, PlanetsStrings.terrainDataField),
              StarWardsDataField().filledData(dataPlanet.surfaceWater,
                  PlanetsStrings.surfaceWaterDataField),
              StarWardsDataField().filledData(
                  dataPlanet.population, PlanetsStrings.populationDataField),
              StarWardsDataField().filledData(
                  dataPlanet.residents != null &&
                          dataPlanet.residents!.isNotEmpty
                      ? dataSpecies.name
                      : null,
                  PlanetsStrings.residentsDataField),
              StarWardsDataField().filledData(
                  dataPlanet.films != null && dataPlanet.films!.isNotEmpty
                      ? dataFilms.title
                      : null,
                  PlanetsStrings.filmsDataField),
            ],
          ),
        ),
      ),
    );
  }
}
