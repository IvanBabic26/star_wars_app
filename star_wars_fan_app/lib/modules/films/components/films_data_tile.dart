import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/components/pagination_bottom_output.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_styles.dart';
import 'package:star_wars_fan_app/modules/films/components/films_data_card.dart';
import 'package:star_wars_fan_app/modules/films/constants/films_strings.dart';
import 'package:star_wars_fan_app/modules/films/models/films_model.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';

class FilmsDataTile extends StatelessWidget {
  FilmsDataTile({Key? key, this.search}) : super(key: key);
  final String? search;
  List<FilmsModel> filteredList = [];
  @override
  Widget build(BuildContext context) {
    filteredList = Provider.of<FilmsStore>(context, listen: true).filmsList!;

    if ((search!.isNotEmpty)) {
      List<FilmsModel> tmpList = [];
      for (int i = 0; i < filteredList.length; i++) {
        if (filteredList[i]
                .title!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .episodeId!
                .toString()
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .openingCrawl!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .director!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .producer!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .releaseDate!
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
                        FilmsStrings.expansionTileTitle,
                        style: kExpansionTileTitle,
                      ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<FilmsStore>(context, listen: true)
                              .filmsList ==
                          null
                      ? 0
                      : filteredList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FilmsDataCard(index: index);
                  },
                ),
              ],
            ),
          )
        : ExpansionTile(
            iconColor: kExpansionPanelButton,
            collapsedIconColor: kExpansionPanelButton,
            title: const Text(
              FilmsStrings.expansionTileTitle,
              style: kExpansionTileTitle,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Provider.of<FilmsStore>(context, listen: true)
                        .filmsList!
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return FilmsDataCard(index: index);
                    }),
              ),
              PaginationBottomOutput(
                name: FilmsStrings.expansionTileTitle,
                loadMore: Provider.of<FilmsStore>(context, listen: true)
                    .isLoadMoreRunning,
                hasNextPage:
                    Provider.of<FilmsStore>(context, listen: true).hasNextPage,
              ),
            ],
          );
  }
}
