import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {

  final IconData iconData;
  final VoidCallback onPressed;
  bool isElegance;

  FloatingActionButtonGreen({
    Key key,
    @required this.iconData,
    @required this.onPressed,
    this.isElegance,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingActionButtonGreen();
  }

}


class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen> {

  /*void onPressedFav(){
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Agregaste a tus Favoritos"),
        )
    );
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      backgroundColor: widget.isElegance ? Colors.white : Color(0xFF11DA53),
      mini: true,
      tooltip: "Selecciona una foto",
      onPressed: widget.onPressed,
      child: Icon(widget.iconData, color: widget.isElegance ? Color(0xFF212121) : Colors.white,),
      heroTag: null,
    );
  }

}