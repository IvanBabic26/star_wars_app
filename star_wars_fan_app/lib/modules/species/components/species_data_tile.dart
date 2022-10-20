import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/components/pagination_bottom_output.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_styles.dart';
import 'package:star_wars_fan_app/modules/species/components/species_data_card.dart';
import 'package:star_wars_fan_app/modules/species/constants/species_strings.dart';
import 'package:star_wars_fan_app/modules/species/models/species_model.dart';
import 'package:star_wars_fan_app/modules/species/store/species_store.dart';

class SpeciesDataTile extends StatelessWidget {
  SpeciesDataTile({
    Key? key,
    this.search,
  }) : super(key: key);

  final String? search;
  List<SpeciesModel> filteredList = [];
  @override
  Widget build(BuildContext context) {
    filteredList =
        Provider.of<SpeciesStore>(context, listen: true).speciesList!;

    if ((search!.isNotEmpty)) {
      List<SpeciesModel> tmpList = [];
      for (int i = 0; i < filteredList.length; i++) {
        if (filteredList[i]
                .name!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .classification!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .designation!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .averageHeight!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .skinColors!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .hairColors!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .eyeColors!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .averageLifespan!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .language!
                .toLowerCase()
                .contains(search!.toLowerCase())) {
          tmpList.add(filteredList[i]);
        }
      }
      filteredList = tmpList;
    }

    return search!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                filteredList.isEmpty
                    ? Container()
                    : const Text(
                        SpeciesStrings.expansionTileTitle,
                        style: kExpansionTileTitle,
                      ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<SpeciesStore>(context, listen: true)
                              .speciesList ==
                          null
                      ? 0
                      : filteredList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SpeciesDataCard(index: index);
                  },
                ),
              ],
            ),
          )
        : ExpansionTile(
            iconColor: kExpansionPanelButton,
            collapsedIconColor: kExpansionPanelButton,
            title: const Text(
              SpeciesStrings.expansionTileTitle,
              style: kExpansionTileTitle,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<SpeciesStore>(context, listen: true)
                      .speciesList!
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return SpeciesDataCard(index: index);
                  },
                ),
              ),
              PaginationBottomOutput(
                name: SpeciesStrings.expansionTileTitle,
                loadMore: Provider.of<SpeciesStore>(context, listen: true)
                    .isLoadMoreRunning,
                hasNextPage: Provider.of<SpeciesStore>(context, listen: true)
                    .hasNextPage,
              ),
            ],
          );
  }
}
