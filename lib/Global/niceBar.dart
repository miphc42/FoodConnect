import 'package:flutter/material.dart';

class NiceBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'FoodConnect',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'TenaliRamakrishna',
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
