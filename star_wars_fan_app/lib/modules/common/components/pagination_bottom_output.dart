import 'package:flutter/material.dart';

class PaginationBottomOutput extends StatelessWidget {
  const PaginationBottomOutput(
      {Key? key, this.name, this.loadMore, this.hasNextPage})
      : super(key: key);
  final String? name;
  final bool? loadMore;
  final bool? hasNextPage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (loadMore == true)
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        // When nothing else to load
        if (hasNextPage == false)
          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 40),
            color: Colors.amber,
            child: Center(
              child: Text('You have fetched all Star Wars $name data'),
            ),
          )
      ],
    );
  }
}
