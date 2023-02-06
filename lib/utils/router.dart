import 'package:flutter/cupertino.dart';

nextPage(BuildContext context, Widget page) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
}

nextPageReplacement(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context, CupertinoPageRoute(builder: (context) => page));
}
