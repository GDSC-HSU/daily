import 'package:flutter/material.dart';

class CardArticle extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String imageURL;
  const CardArticle(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.imageURL});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      width: 318,
      height: 112,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE8F1FF), width: 4)),
      child: Row(children: [
        Image.network(
          imageURL,
          fit: BoxFit.fill,
          width: 109,
          height: 93,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF041A3C)),
              ),
              Text(
                description,
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.bookmark,
                    size: 12,
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
