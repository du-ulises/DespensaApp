import 'package:flutter/material.dart';
import 'package:despensaapp/Ticket/theme.dart';

class LocationWidget extends StatelessWidget {
  final String stationName, cityName, time;

  LocationWidget(
      {@required this.stationName,
        @required this.cityName,
        @required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(stationName.toUpperCase(), style: bigTextStyle),
        SizedBox(height: 2.0),
        Text(cityName, style: mediumTextStyle),
        SizedBox(height: 2.0),
        Text(time, style: smallTextStyle),
      ],
    );
  }
}