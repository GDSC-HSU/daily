import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dialogs/informations_dialog.dart';
import 'bookmark_icon.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final String publishedAt;
  final String urlToImage;
  final String author;
  final String content;

  const ArticleCard(
      {super.key,
      required this.title,
      required this.description,
      required this.publishedAt,
      required this.author,
      required this.content,
      required this.urlToImage});

  Future openDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => InformationsDialog(
              title: title,
              description: description,
              publishedAt: publishedAt,
              author: author,
              urlToImage: urlToImage,
              content: content,
            ));
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(publishedAt);
    String dateFormat = DateFormat("EEEE MM yyyy").format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          openDialog(context);
        },
        child: Container(
          height: 112,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE8F1FF), width: 2),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  urlToImage,
                  width: 109,
                  height: 93,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(0xFF041A3C)),
                            ),
                            SizedBox(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 7, 9),
                                child: Text(
                                  description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                dateFormat,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              BookmarkIcon(
                                title: title,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
