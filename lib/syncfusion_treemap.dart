import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';

class Treemap extends StatefulWidget {
  const Treemap({Key key}) : super(key: key);

  @override
  _TreemapState createState() => _TreemapState();
}

class _TreemapState extends State<Treemap> {
  List<SocialMediaUsers> _treemapData;
  @override
  void initState() {
    _treemapData = getTreemapData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfTreemap(
          dataCount: _treemapData.length,
          levels: [
            TreemapLevel(groupMapper: (int index) {
              return _treemapData[index].country;
            }, labelBuilder: (BuildContext context, TreemapTile tile) {
              return Padding(
                  padding: EdgeInsets.all(2.5), child: Text(tile.group));
            }, tooltipBuilder: (BuildContext context, TreemapTile tile) {
              return Padding(
                  padding: EdgeInsets.all(2.5),
                  child: Text(
                      'Country: ${tile.group}\nSocial media: ${tile.weight}M',
                      style: TextStyle(color: Colors.white)));
            })
          ],
          weightValueMapper: (int index) {
            return _treemapData[index].usersInMillions;
          },
          legend: TreemapLegend(position: TreemapLegendPosition.bottom)),
    ));
  }

  List<SocialMediaUsers> getTreemapData() {
    return <SocialMediaUsers>[
      SocialMediaUsers('India', 'Facebook', 25.4),
      SocialMediaUsers('USA', 'Instagram', 19.11),
      SocialMediaUsers('Japan', 'Facebook', 13.3),
      SocialMediaUsers('Germany', 'Instagram', 10.65),
      SocialMediaUsers('France', 'Twitter', 7.54),
      SocialMediaUsers('UK', 'Instagram', 4.93)
    ];
  }
}

class SocialMediaUsers {
  SocialMediaUsers(this.country, this.socialMedia, this.usersInMillions);
  final String country;
  final String socialMedia;
  final double usersInMillions;
}
