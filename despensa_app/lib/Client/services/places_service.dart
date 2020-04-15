import 'package:despensaapp/Client/model/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyCNL7LscMhrPuGxDhlqIlTGtoF-b7tzSjM';

  Future<List<Place>> getPlaces(double lat, double lng, BitmapDescriptor icon) async {
    print('Getting places...');
    var response = await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=store&rankby=distance&key=$key');
    print(response.body);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place,icon)).toList();
  }

}