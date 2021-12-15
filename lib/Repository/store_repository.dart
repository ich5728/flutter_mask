import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_mask/model/store.dart';
import 'package:latlong/latlong.dart';

class StoreRepository {
  final _distance = Distance();

  Future<List<Store>> fetch(double lat, double lng) async {
    final stores = List<Store>();

    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body);
        final jsonStores = jsonResult['stores'];

        jsonStores.forEach((e) {
          final store = Store.fromJson(e);
          final km = _distance.as(LengthUnit.Kilometer,
              LatLng(store.lat, store.lng), LatLng(lat, lng));
          store.km = km;
          stores.add(store);
        });
        print("fetch complete");

        return stores.where((e) {
          return e.remainStat == 'plenty' ||
              e.remainStat == 'some' ||
              e.remainStat == 'few';
        }).toList()
          ..sort((a, b) => a.km.compareTo(b.km));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
