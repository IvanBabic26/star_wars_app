import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_strings.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_styles.dart';
import 'package:star_wars_fan_app/modules/films/components/films_data_tile.dart';
import 'package:star_wars_fan_app/modules/films/service/films_actions.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';
import 'package:star_wars_fan_app/modules/planets/components/planets_data_tile.dart';
import 'package:star_wars_fan_app/modules/planets/service/planets_actions.dart';
import 'package:star_wars_fan_app/modules/species/components/species_data_tile.dart';
import 'package:star_wars_fan_app/modules/species/service/species_actions.dart';
import 'package:star_wars_fan_app/modules/species/store/species_store.dart';
import 'package:star_wars_fan_app/modules/people/components/people_data_tile.dart';
import 'package:star_wars_fan_app/modules/people/service/star_wars_actions.dart';
import 'package:star_wars_fan_app/modules/people/store/people_store.dart';
import 'package:star_wars_fan_app/modules/starships/components/starship_data_tile.dart';
import 'package:star_wars_fan_app/modules/starships/service/starships_actions.dart';
import 'package:star_wars_fan_app/modules/starships/store/starships_store.dart';
import 'package:star_wars_fan_app/modules/vehicles/components/vehicle_data_tile.dart';
import 'package:star_wars_fan_app/modules/vehicles/service/vehicles_actions.dart';
import 'package:star_wars_fan_app/modules/vehicles/store/vehicles_store.dart';
import 'package:star_wars_fan_app/modules/planets/store/planets_store.dart';

class StarWarsMainScreen extends StatefulWidget {
  static const idMain = CommonStrings.idMain;
  const StarWarsMainScreen({Key? key}) : super(key: key);

  @override
  State<StarWarsMainScreen> createState() => _StarWarsMainScreenState();
}

class _StarWarsMainScreenState extends State<StarWarsMainScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';
  int number = 1;

  Widget searchBar() {
    switch (number) {
      case 1:
        return Text(
          CommonStrings.appBarTitle,
          textAlign: TextAlign.left,
          style: kExpansionTileTitle.copyWith(fontSize: 20),
        );
      case 2:
        return TextField(
          autofocus: true,
          style: kExpansionTileTitle,
          controller: _searchController,
          decoration: const InputDecoration(
              hintText: CommonStrings.searchTextFieldHint,
              border: InputBorder.none),
          onChanged: (value) {
            setState(
              () {
                _searchResult = value;
              },
            );
          },
        );
    }
    return Text(
      CommonStrings.appBarTitle,
      textAlign: TextAlign.left,
      style: kExpansionTileTitle.copyWith(fontSize: 20),
    );
  }

  fetchData() {
    Provider.of<PeopleStore>(context, listen: false).fetchMorePeople();
    Provider.of<PlanetsStore>(context, listen: false).fetchMorePlanets();
    Provider.of<SpeciesStore>(context, listen: false).fetchMoreSpecies();
    Provider.of<VehicleStore>(context, listen: false).fetchMoreVehicles();
    Provider.of<StarshipStore>(context, listen: false).fetchMoreStarships();
    Provider.of<FilmsStore>(context, listen: false).fetchMoreFilms();
  }

  @override
  void initState() {
    peopleData = PeopleActions(context).fetchPeople();
    planetsData = PlanetsActions(context).fetchPlanets();
    speciesData = SpeciesActions(context).fetchSpecies();
    vehiclesData = VehicleActions(context).fetchVehicles();
    starshipsData = StarshipActions(context).fetchStarships();
    filmsData = FilmsActions(context).fetchFilms();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (Provider.of<PeopleStore>(context, listen: false).hasNextPage == true &&
        Provider.of<PeopleStore>(context, listen: false).isFirstLoadRunning ==
            false &&
        Provider.of<PeopleStore>(context, listen: false).isLoadMoreRunning ==
            false &&
        _scrollController.position.extentAfter < 300) {
      Provider.of<PeopleStore>(context, listen: false)
          .setMoreLoading(true); // Display a progress indicator at the bottom

      try {
        fetchData();
        if (fetchData() != null) {
        } else {
          /// This means there is no more data and therefore, we will not send another GET request

          Provider.of<PeopleStore>(context, listen: false).setNextPage(false);
        }
      } catch (err) {
        Provider.of<PeopleStore>(context, listen: false).setNextPage(false);

        if (kDebugMode) {
          print('Something went wrong!');
        }
      }
    }

    Provider.of<PeopleStore>(context, listen: false).setMoreLoading(false);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  late Future peopleData;
  late Future planetsData;
  late Future starshipsData;
  late Future vehiclesData;
  late Future speciesData;
  late Future filmsData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(0, 0, 0, 0.87),
        ),
        title: searchBar(),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              number == 1
                  ? IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 28.0,
                        color: kExpansionPanelButton,
                      ),
                      onPressed: () {
                        setState(() {
                          number = 2;
                        });
                      })
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchResult = '';
                          number = 1;
                        });
                      },
                      icon: const Icon(
                        Icons.cancel,
                        size: 28.0,
                        color: kExpansionPanelButton,
                      ),
                    ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait(
            [
              peopleData,
              planetsData,
              filmsData,
              speciesData,
              vehiclesData,
              starshipsData,
            ],
          ),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      PeopleDataTile(
                        search: _searchResult,
                      ),
                      SpeciesDataTile(
                        search: _searchResult,
                      ),
                      PlanetsDataTile(
                        search: _searchResult,
                      ),
                      StarshipDataTile(
                        search: _searchResult,
                      ),
                      VehicleDataTile(
                        search: _searchResult,
                      ),
                      FilmsDataTile(
                        search: _searchResult,
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ),
    );
  }
}
