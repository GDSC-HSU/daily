import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformationsDialog extends StatelessWidget {
  final String urlToImage;
  final String title;
  final String publishedAt;
  final String author;
  final String description;
  final String content;

  const InformationsDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.author,
      required this.publishedAt,
      required this.content,
      required this.urlToImage});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(publishedAt);
    String dateFormat = DateFormat("EEEE MM yyyy").format(date);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 500,
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                urlToImage,
                height: 147,
                width: 280,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: 234,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xFF041A3C),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        dateFormat,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: double.maxFinite,
                        height: 2,
                      ),
                      Text(
                        author,
                        style: const TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        width: double.maxFinite,
                        height: 8,
                      ),
                      Expanded(
                        child: Text(
                          content,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
