import 'package:flutter/material.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_strings.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_styles.dart';

class StartWarsDataDetails extends StatelessWidget {
  static const idDetails = CommonStrings.idDetails;
  const StartWarsDataDetails({
    Key? key,
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.gender,
    this.homeWorld,
    this.birthYear,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.rotationPeriod,
    this.orbitalPeriod,
    this.diameter,
    this.climate,
    this.gravity,
    this.terrain,
    this.surfaceWater,
    this.population,
    this.residents,
    this.title,
    this.episodeId,
    this.openingCrawl,
    this.director,
    this.producer,
    this.releaseDate,
    this.characters,
    this.planets,
    this.classification,
    this.designation,
    this.averageHeight,
    this.skinColorSpecies,
    this.hairColorSpecies,
    this.eyeColorSpecies,
    this.averageLifespan,
    this.homeWorldSpecies,
    this.language,
    this.people,
    this.model,
    this.manufacturer,
    this.costInCredits,
    this.length,
    this.maxAtmospheringSpeed,
    this.crew,
    this.passengers,
    this.cargoCapacity,
    this.consumables,
    this.vehicleClass,
    this.pilots,
    this.hyperdriveRating,
    this.mGLT,
    this.starshipClass,
  }) : super(key: key);

  /// people data
  final String? name;
  final String? height;
  final String? mass;
  final String? hairColor;
  final String? skinColor;
  final String? eyeColor;
  final String? gender;
  final String? homeWorld;
  final String? birthYear;
  final String? films;
  final String? species;
  final String? vehicles;
  final String? starships;

  /// planets data
  final String? rotationPeriod;
  final String? orbitalPeriod;
  final String? diameter;
  final String? climate;
  final String? gravity;
  final String? terrain;
  final String? surfaceWater;
  final String? population;
  final String? residents;

  /// films data
  final int? episodeId;
  final String? title;
  final String? openingCrawl;
  final String? director;
  final String? producer;
  final String? releaseDate;
  final String? characters;
  final String? planets;

  /// species data
  final String? classification;
  final String? designation;
  final String? averageHeight;
  final String? skinColorSpecies;
  final String? hairColorSpecies;
  final String? eyeColorSpecies;
  final String? averageLifespan;
  final String? homeWorldSpecies;
  final String? language;
  final String? people;

  /// vehicles data
  final String? model;
  final String? manufacturer;
  final String? costInCredits;
  final String? length;
  final String? maxAtmospheringSpeed;
  final String? crew;
  final String? passengers;
  final String? cargoCapacity;
  final String? consumables;
  final String? vehicleClass;
  final String? pilots;

  /// starships data
  final String? hyperdriveRating;
  final String? mGLT;
  final String? starshipClass;

  String capitalize(String? string) {
    return "${string![0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }

  Widget filledData(String? data, String title) {
    switch (data) {
      case null:
        return Container();
      case 'null':
        return Container();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: kCardDataTitle,
          ),
          Expanded(
              child: Text(
            capitalize(data!),
            style: kCardDataValue,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: kExpansionPanelButton,
        ),
        title: Text(
          CommonStrings.detailsInfoTitle.toUpperCase(),
          style: kExpansionTileTitle.copyWith(fontSize: 16.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                CommonStrings.detailsInfoSubTitle,
                style: kCardDataValue,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    elevation: 8.0,
                    child: Column(
                      children: [
                        filledData(name, 'Name: '),
                        filledData(height, 'Height: '),
                        filledData(mass, 'Mass: '),
                        filledData(hairColor, 'Hair color: '),
                        filledData(skinColor, 'Skin color: '),
                        filledData(eyeColor, 'Eye color: '),
                        filledData(gender, 'Gender: '),
                        filledData(homeWorld, 'Home world: '),
                        filledData(birthYear, 'Date of birth: '),
                        filledData(films, 'Films: '),
                        filledData(species, 'Species: '),
                        filledData(vehicles, 'Vehicles: '),
                        filledData(starships, 'Starships: '),
                        filledData(rotationPeriod, 'Rotation period: '),
                        filledData(orbitalPeriod, 'Orbital period: '),
                        filledData(diameter, 'Diameter: '),
                        filledData(climate, 'Climate: '),
                        filledData(gravity, 'Gravity: '),
                        filledData(terrain, 'Terrain: '),
                        filledData(surfaceWater, 'Surface water: '),
                        filledData(population, 'Population: '),
                        filledData(residents, 'Residents: '),
                        filledData(episodeId.toString(), 'Episode ID: '),
                        filledData(residents, 'Residents: '),
                        filledData(openingCrawl, 'Opening crawl: '),
                        filledData(director, 'Director: '),
                        filledData(producer, 'Producer: '),
                        filledData(releaseDate, 'Release date: '),
                        filledData(characters, 'Characters: '),
                        filledData(planets, 'Planets: '),
                        filledData(classification, 'Director: '),
                        filledData(designation, 'Producer: '),
                        filledData(averageHeight, 'Release date: '),
                        filledData(skinColorSpecies, 'Opening crawl: '),
                        filledData(hairColorSpecies, 'Director: '),
                        filledData(eyeColorSpecies, 'Producer: '),
                        filledData(averageLifespan, 'Release date: '),
                        filledData(homeWorldSpecies, 'Characters: '),
                        filledData(language, 'Planets: '),
                        filledData(people, 'Director: '),
                        filledData(model, 'Producer: '),
                        filledData(manufacturer, 'Release date: '),
                        filledData(costInCredits, 'Opening crawl: '),
                        filledData(length, 'Director: '),
                        filledData(maxAtmospheringSpeed, 'Producer: '),
                        filledData(crew, 'Release date: '),
                        filledData(passengers, 'Characters: '),
                        filledData(cargoCapacity, 'Planets: '),
                        filledData(consumables, 'Producer: '),
                        filledData(vehicleClass, 'Release date: '),
                        filledData(pilots, 'Opening crawl: '),
                        filledData(hyperdriveRating, 'Director: '),
                        filledData(mGLT, 'Producer: '),
                        filledData(starshipClass, 'Producer: '),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
