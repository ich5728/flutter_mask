import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_mask/Repository/store_repository.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/repository/location_repository.dart';
import 'package:geolocator/geolocator.dart';

class StoreModel with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = [];

  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  StoreModel() {
    fetch();
  }
  Future fetch() async {
    isLoading = true;
    notifyListeners();

    Position position = await _locationRepository.getCurrentLocation();

    stores =
        await _storeRepository.fetch(position.latitude, position.longitude);
    isLoading = false;
    notifyListeners(); //바뀐것을 확인하고 알려줌
  }
}
