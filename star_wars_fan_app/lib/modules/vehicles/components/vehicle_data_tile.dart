import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/components/pagination_bottom_output.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_styles.dart';
import 'package:star_wars_fan_app/modules/vehicles/components/vehicle_data_card.dart';
import 'package:star_wars_fan_app/modules/vehicles/constants/vehicles_strings.dart';
import 'package:star_wars_fan_app/modules/vehicles/models/vehicles_model.dart';
import 'package:star_wars_fan_app/modules/vehicles/store/vehicles_store.dart';

class VehicleDataTile extends StatelessWidget {
  VehicleDataTile({super.key, this.search});
  final String? search;
  List<VehicleModel> filteredList = [];
  @override
  Widget build(BuildContext context) {
    filteredList =
        Provider.of<VehicleStore>(context, listen: true).vehiclesList!;

    if ((search!.isNotEmpty)) {
      List<VehicleModel> tmpList = [];
      for (int i = 0; i < filteredList.length; i++) {
        if (filteredList[i]
                .name!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .model!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .manufacturer!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .costInCredits!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .length!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .maxAtmospheringSpeed!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .crew!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .passengers!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .cargoCapacity!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .consumables!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .vehicleClass!
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
                        VehiclesStrings.expansionTileTitle,
                        style: kExpansionTileTitle,
                      ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<VehicleStore>(context, listen: true)
                              .vehiclesList ==
                          null
                      ? 0
                      : filteredList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return VehicleDataCard(index: index);
                  },
                ),
              ],
            ),
          )
        : ExpansionTile(
            iconColor: kExpansionPanelButton,
            collapsedIconColor: kExpansionPanelButton,
            title: const Text(
              VehiclesStrings.expansionTileTitle,
              style: kExpansionTileTitle,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Provider.of<VehicleStore>(context, listen: true)
                        .vehiclesList!
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return VehicleDataCard(index: index);
                    }),
              ),
              PaginationBottomOutput(
                name: VehiclesStrings.expansionTileTitle,
                loadMore: Provider.of<VehicleStore>(context, listen: true)
                    .isLoadMoreRunning,
                hasNextPage: Provider.of<VehicleStore>(context, listen: true)
                    .hasNextPage,
              ),
            ],
          );
  }
}
