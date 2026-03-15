import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddressProvider with ChangeNotifier {
  final Box _addressBox = Hive.box('addresses');
  
  String? _currentAddress;
  Position? _currentPosition;
  List<String> _savedAddresses = [];
  bool _isLoading = false;
  String? _error;

  String? get currentAddress => _currentAddress;
  Position? get currentPosition => _currentPosition;
  List<String> get savedAddresses => [..._savedAddresses];
  bool get isLoading => _isLoading;
  String? get error => _error;

  AddressProvider() {
    _loadAddresses();
  }

  void _loadAddresses() {
    _savedAddresses = _addressBox.values.cast<String>().toList();
    if (_savedAddresses.isNotEmpty) {
      _currentAddress = _savedAddresses.first;
    }
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw 'Location services are disabled.';

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) throw 'Location permissions are denied';
      }

      if (permission == LocationPermission.deniedForever) throw 'Location permissions are permanently denied';

      _currentPosition = await Geolocator.getCurrentPosition();
      _currentAddress = "Mock Address at ${_currentPosition!.latitude}, ${_currentPosition!.longitude}";
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addAddress(String address) {
    if (!_savedAddresses.contains(address)) {
      _savedAddresses.add(address);
      _addressBox.add(address);
      _currentAddress = address;
      notifyListeners();
    }
  }

  void removeAddress(int index) {
    _savedAddresses.removeAt(index);
    _addressBox.deleteAt(index);
    notifyListeners();
  }

  void selectAddress(String address) {
    _currentAddress = address;
    notifyListeners();
  }

  void setManualAddress(String address) {
    _currentAddress = address;
    addAddress(address);
    notifyListeners();
  }
}
