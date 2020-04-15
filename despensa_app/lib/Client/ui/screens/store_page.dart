import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:despensaapp/Client/services/geolocator_service.dart';
import 'package:despensaapp/Client/services/marker_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:despensaapp/Client/model/place.dart';

class StorePage extends KFDrawerContent {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    final styleItems = TextStyle(
        fontSize: 13.0,
        color: Colors.black54,
        fontFamily: 'Poppins-Regular'
    );
    final styleTitle = TextStyle(
        fontSize: 14,
        fontFamily: "Poppins-SemiBold",
        color: Colors.black,
    );

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        backgroundColor: Color(0xFFC42036),
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  var markers = (places != null)
                      ? markerService.getMarkers(places)
                      : List<Marker>();
                  return (places != null)
                      ? SafeArea(
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0)),
                                        child: Material(
                                          shadowColor: Colors.transparent,
                                          color: Colors.transparent,
                                          child: IconButton(
                                            icon: Icon(Icons.menu,
                                                color: Colors.black),
                                            onPressed: widget.onMenuPressed,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Tiendas',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: "Poppins-Medium",
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                      color: Colors.white,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 15.0,
                                            offset: Offset(7.0, 7.0))
                                      ]),
                                  padding: EdgeInsets.only(bottom: 5, top: 5),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                SizedBox(
                                  height: 5.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.width,
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(currentPosition.latitude,
                                            currentPosition.longitude),
                                        zoom: 16.0),
                                    zoomGesturesEnabled: true,
                                    markers: Set<Marker>.of(markers),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFC42036),
                                        ),
                                    child: ListView.builder(
                                        itemCount: places.length,
                                        itemBuilder: (context, index) {
                                          return FutureProvider(
                                            create: (context) =>
                                                geoService.getDistance(
                                                    currentPosition.latitude,
                                                    currentPosition.longitude,
                                                    places[index]
                                                        .geometry
                                                        .location
                                                        .lat,
                                                    places[index]
                                                        .geometry
                                                        .location
                                                        .lng),
                                            child: Card(
                                              child: ListTile(
                                                title: Text(
                                                  places[index].name,
                                                  style: styleTitle,
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    (places[index].rating != null)
                                                        ? Row(
                                                      children: <Widget>[
                                                        RatingBarIndicator(
                                                          rating:
                                                          places[index]
                                                              .rating,
                                                          itemBuilder: (context,
                                                              index) =>
                                                              Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0xFFC42036)),
                                                          itemCount: 5,
                                                          itemSize: 12.0,
                                                          direction: Axis
                                                              .horizontal,
                                                        )
                                                      ],
                                                    )
                                                        : Row(),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Consumer<double>(
                                                      builder: (context, meters,
                                                          wiget) {
                                                        return (meters != null)
                                                            ? Text(
                                                          '${places[index].vicinity} \u00b7 ${(meters / 1609).round()} mi',
                                                          style: styleItems,
                                                        )
                                                            : Container();
                                                      },
                                                    )
                                                  ],
                                                ),
                                                trailing: IconButton(
                                                  icon: Icon(Icons.directions),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  onPressed: () {
                                                    _launchMapsUrl(
                                                        places[index]
                                                            .geometry
                                                            .location
                                                            .lat,
                                                        places[index]
                                                            .geometry
                                                            .location
                                                            .lng);
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : SafeArea(
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0)),
                                        child: Material(
                                          shadowColor: Colors.transparent,
                                          color: Colors.transparent,
                                          child: IconButton(
                                            icon: Icon(Icons.menu,
                                                color: Colors.black),
                                            onPressed: widget.onMenuPressed,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Tiendas',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: "Poppins-Medium",
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                      color: Colors.white,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 15.0,
                                            offset: Offset(7.0, 7.0))
                                      ]),
                                  padding: EdgeInsets.only(bottom: 5, top: 5),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Color(0xFFC42036)),
                                          backgroundColor: Colors.black)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              )
            : SafeArea(
                child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                            child: Material(
                              shadowColor: Colors.transparent,
                              color: Colors.transparent,
                              child: IconButton(
                                icon: Icon(Icons.menu, color: Colors.black),
                                onPressed: widget.onMenuPressed,
                              ),
                            ),
                          ),
                          Text(
                            'Tiendas',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Poppins-Medium",
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15.0,
                                offset: Offset(7.0, 7.0))
                          ]),
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color(0xFFC42036)),
                              backgroundColor: Colors.black)
                        ],
                      ),
                    ),
                  ],
                ),
              )),
      ),
    );
  }

  void _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
