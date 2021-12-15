import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:url_launcher/url_launcher.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;
  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(store.addr), Text('${store.km}km')],
      ),
      trailing: _buildRemainStatWidget(store),
      onTap: () {
        _launcherURL(store.lat, store.lng);
      },
    );
  }

  Widget _buildRemainStatWidget(Store store) {
    var remainState = '판매중지'; //null
    var descripstion = '판매중지';
    var color = Colors.black;

    switch (store.remainStat) {
      case 'plenty':
        remainState = '충분';
        descripstion = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainState = '보통';
        descripstion = '30 ~ 100개';
        color = Colors.yellow;
        break;
      case 'few':
        remainState = '부족';
        descripstion = '2 ~ 30개';
        color = Colors.red;
        break;
      case 'empty':
        remainState = '소진임박';
        descripstion = '100개 이상';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: [
        Text(remainState,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        Text(
          descripstion,
          style: TextStyle(color: color),
        )
      ],
    );
  }

  _launcherURL(double lat, double lng) async {
    final url = 'https://google.com/maps/search/?api=1&querry= $lat, $lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
