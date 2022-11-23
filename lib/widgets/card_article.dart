import 'package:flutter/material.dart';

class CardArticle extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  const CardArticle(
      {super.key,
      required this.title,
      required this.description,
      required this.date});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 318,
      height: 112,
      child: Row(children: [
        Image.network(
            "https://s.yimg.com/os/creatr-uploaded-images/2022-10/32d0f3b0-521c-11ed-bad3-4bf45e1f7ed2"),
        Column(
          children: [
            Text(title),
            Text(description),
            Row(
              children: [Text(date), const Icon(Icons.ac_unit_sharp)],
            )
          ],
        ),
      ]),
    );
  }
}
