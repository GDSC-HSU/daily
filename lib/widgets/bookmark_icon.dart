import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkIcon extends StatefulWidget {
  final String title;

  const BookmarkIcon({super.key, required this.title});

  @override
  _BookmarkIconState createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  bool isMark = false;

  void setMark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.title, !isMark);

    setState(() {
      isMark = !isMark;
    });
  }

  Future<void> getMark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isMark = prefs.getBool(widget.title) ?? false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMark();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setMark();
      },
      child: Icon(
        Icons.bookmark_sharp,
        size: 13,
        color: isMark ? Colors.amber : Colors.black,
      ),
    );
  }
}
