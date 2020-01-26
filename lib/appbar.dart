import 'package:flutter/material.dart';
import 'hexcolor.dart';

class MonAppBar extends StatefulWidget implements PreferredSizeWidget {
    MonAppBar({Key key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key );

    @override
    final Size preferredSize; // default is 56.0

    @override
    _MonAppBarState createState() => _MonAppBarState();
}

class _MonAppBarState extends State<MonAppBar>{
    
    @override
    Widget build(BuildContext context) {
        return AppBar(backgroundColor: new HexColor("FFB838"), );
    }
}