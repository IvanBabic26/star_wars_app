import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/screens/star_wars_splash_screen.dart';
import 'package:star_wars_fan_app/modules/common/screens/start_wars_data_details.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';
import 'package:star_wars_fan_app/modules/planets/store/planets_store.dart';
import 'package:star_wars_fan_app/modules/species/store/species_store.dart';
import 'package:star_wars_fan_app/modules/common/screens/star_wars_screen.dart';
import 'package:star_wars_fan_app/modules/people/store/people_store.dart';
import 'package:star_wars_fan_app/modules/starships/store/starships_store.dart';
import 'package:star_wars_fan_app/modules/vehicles/store/vehicles_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PeopleStore>(create: (_) => PeopleStore()),
        ChangeNotifierProvider<PlanetsStore>(create: (_) => PlanetsStore()),
        ChangeNotifierProvider<SpeciesStore>(create: (_) => SpeciesStore()),
        ChangeNotifierProvider<FilmsStore>(create: (_) => FilmsStore()),
        ChangeNotifierProvider<StarshipStore>(create: (_) => StarshipStore()),
        ChangeNotifierProvider<VehicleStore>(create: (_) => VehicleStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const StarWarsSplashScreen(),
        routes: {
          StarWarsMainScreen.idMain: (context) => const StarWarsMainScreen(),
          StartWarsDataDetails.idDetails: (context) =>
              const StartWarsDataDetails(),
        },
      ),
    );
  }
}
