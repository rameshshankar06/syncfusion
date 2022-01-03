import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class Map extends StatefulWidget {
  const Map({Key key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  MapShapeSource _shapeSource;
  List<MapModel> _mapData;

  @override
  void initState() {
    _mapData = _getMapData();
    _shapeSource = MapShapeSource.asset('assets/australia.json',
        shapeDataField: 'STATE_NAME',
        dataCount: _mapData.length,
        primaryValueMapper: (int index) => _mapData[index].state,
        dataLabelMapper: (int index) => _mapData[index].stateCode,
        shapeColorValueMapper: (int index) => _mapData[index].color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    //  body: Padding(
    //     padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
    //    child: SfMaps(
    //      layers: [
    //        MapTileLayer(
    //        urlTemplate: 'https:tile.openstreetmap.org/{z}/{x}/{y}.png',
    //        initialFocalLatLng: MapLatLng(-20, 147),
    //        initialZoomLevel: 3,
    //      )
    //    ],
    //  )),
    //  );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: SfMaps(
          // title: const MapTitle('Austraila Map'),
          layers: <MapShapeLayer>[
            MapShapeLayer(
              source: _shapeSource,
              showDataLabels: true,
              legend: MapLegend(MapElement.shape),
              shapeTooltipBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.all(7),
                    child: Text(_mapData[index].stateCode,
                        style: TextStyle(color: Colors.white)));
              },
              tooltipSettings: MapTooltipSettings(color: Colors.blue[900]),
            )
          ],
        ),
      ),
    );
  }

  static List<MapModel> _getMapData() {
    return <MapModel>[
      MapModel('Australian Capital Territory', 'ACT', Colors.amber),
      MapModel('New South Wales', '       New\nSouth Wales', Colors.cyan),
      MapModel('Queensland', 'Queensland', Colors.amber[400]),
      MapModel('Northern Territory', 'Northern\nTerritory', Colors.red[400]),
      MapModel('Victoria', 'Victoria', Colors.purple[400]),
      MapModel(
          'South Australia', 'South Australia', Colors.lightGreenAccent[200]),
      MapModel('Western Australia', 'Western Australia', Colors.indigo[400]),
      MapModel('Tasmania', 'Tasmania', Colors.lightBlue[100])
    ];
  }
}

class MapModel {
  MapModel(this.state, this.stateCode, this.color);

  String state;
  String stateCode;
  Color color;
}
