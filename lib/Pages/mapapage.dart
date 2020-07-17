import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                mapController.move(LatLng(-2.903785, -79.007530), 15.0);
              })
        ],
        backgroundColor: Colors.pinkAccent,
        title: Text("Location"),
      ),
      body: Center(
        child: _createMap(),
      ),
    );
  }

  Widget _createMap() {
    return FlutterMap(
      mapController: mapController,
      options: new MapOptions(
        center: LatLng(-2.903785, -79.007530),
        zoom: 15.0,
      ),
      layers: [_crearMapa(), _crearMarcadores()],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate:
          "https://atlas.microsoft.com/map/tile/png?api-version=1&layer=basic&style=main&tileSize=256&view=Auto&zoom={z}&x={x}&y={y}&subscription-key={subscriptionKey}",
      additionalOptions: {
        'subscriptionKey': 'Sp6DhyJpUlFZh0A7S98PsNPcEodaC9BHXovGYI2Q0Io'
      },
    );
  }

  _crearMarcadores() {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(-2.903785, -79.007530),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 45.0,
                ),
              ))
    ]);
  }
}
