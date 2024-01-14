import 'package:flutter/material.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final Widget? leading;
  const CustomAppbarWidget({Key? key, this.title = "", this.leading})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: leading,
      backgroundColor: Colors.green[300],
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      ),
      centerTitle: true,
    );
  }
}
