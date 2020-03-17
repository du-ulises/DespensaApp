import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  final VoidCallback onPressed;
  bool mini;
  var icon;
  double iconSize;
  var color;
  var tooltip;

  CircleButton(this.mini, this.icon, this.iconSize, this.color, this.onPressed, this.tooltip);

  @override
  State<StatefulWidget> createState() {
    return _CircleButton();
  }

}

class _CircleButton extends State<CircleButton> {

  void onPressedButton() {

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          mini: widget.mini,
          onPressed: widget.onPressed,
          child: Icon(
            widget.icon,
            size: widget.iconSize,
            color: Color(0xFFC42036),
          ),
          heroTag: null,
          tooltip: widget.tooltip,
        )
    );
  }
}