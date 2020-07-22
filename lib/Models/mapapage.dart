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
    List args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                mapController.move(
                    LatLng(double.parse(args[0]), double.parse(args[1])), 15.0);
              })
        ],
        backgroundColor: Colors.pinkAccent,
        title: Text("Location"),
      ),
      body: Center(
        child: _createMap(args),
      ),
    );
  }

  Widget _createMap(List args) {
    return FlutterMap(
      mapController: mapController,
      options: new MapOptions(
        center: LatLng(double.parse(args[0]), double.parse(args[1])),
        zoom: 15.0,
      ),
      layers: [_crearMapa(), _crearMarcadores(args)],
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

  _crearMarcadores(List args) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(double.parse(args[0]), double.parse(args[1])),
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
