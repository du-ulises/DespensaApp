import 'package:flutter/material.dart';
import 'package:despensaapp/widgets/floating_action_button_green.dart';
import 'package:cached_network_image/cached_network_image.dart';

class  CardImageWithFabIconFab extends StatelessWidget {

  final double height;
  final double width;
  double left;
  double bottom;
  final String pathImage;
  final VoidCallback onPressedFabIcon;
  final IconData iconData;
  bool internet = true;
  bool isElegance = false;

  CardImageWithFabIconFab({
    Key key,
    @required this.pathImage,
    @required this.width,
    @required this.height,
    @required this.onPressedFabIcon,
    @required this.iconData,
    this.isElegance,
    this.internet,
    this.left,
    this.bottom
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final card = Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
          left: left,
          bottom: bottom
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: internet?CachedNetworkImageProvider(pathImage):AssetImage(pathImage)
            //image: CachedNetworkImageProvider(pathImage)
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //shape: BoxShape.rectangle,
          boxShadow: <BoxShadow>[
            BoxShadow (
                color:  Colors.black38,
                blurRadius: 15.0,
                offset: Offset(0.0, 7.0)
            )
          ]

      ),
    );

    return Stack(
      alignment: Alignment(0.95,1.0),
      children: <Widget>[
        card,
        FloatingActionButtonGreen(iconData: iconData, onPressed: onPressedFabIcon, isElegance: isElegance)
      ],
    );
  }

}