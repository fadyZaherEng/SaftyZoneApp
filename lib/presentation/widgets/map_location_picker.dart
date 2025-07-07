import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/utils/helpers/helper_functions.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MapLocationPicker extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;
  final Function(double latitude, double longitude, String address)
      onLocationSelected;

  const MapLocationPicker({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
    required this.onLocationSelected,
  });

  @override
  State<MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  late MapController _mapController;
  LatLng? _selectedLocation;
  String _address = '';
  bool _isLoading = true;
  String? _errorMessage;
  static const double DEFAULT_LAT = 0; // Riyadh
  static const double DEFAULT_LNG = 0; // Riyadh

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception(S.of(context).locationPermissionDenied);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(S.of(context).locationPermissionPermanentlyDenied);
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      // Must wait until map is loaded before moving the controller
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          _mapController.move(_selectedLocation!, 15);
        } catch (e) {
          print('Could not move map controller: ${e.toString()}');
        }
      });

      // Get address for the location
      _getAddressFromCoordinates(_selectedLocation!);
    } catch (e) {
      print('Error getting location: ${e.toString()}');
      // Use provided coordinates as fallback, or default location if none provided
      LatLng fallbackLocation;
      if (widget.initialLatitude != null &&
          widget.initialLongitude != null &&
          widget.initialLatitude != 0 &&
          widget.initialLongitude != 0) {
        fallbackLocation =
            LatLng(widget.initialLatitude!, widget.initialLongitude!);
      } else {
        fallbackLocation = LatLng(DEFAULT_LAT, DEFAULT_LNG);
      }

      setState(() {
        _selectedLocation = fallbackLocation;
        _errorMessage = e.toString();
        _isLoading = false;
      });

      // Must wait until map is loaded before moving the controller
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          _mapController.move(_selectedLocation!, 15);
        } catch (e) {
          print('Could not move map controller: ${e.toString()}');
        }
      });

      // Get address for fallback location
      _getAddressFromCoordinates(_selectedLocation!);
    }
  }

  Future<void> _getAddressFromCoordinates(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country,
        ].where((element) => element != null && element.isNotEmpty).join(', ');

        setState(() {
          _address = address;
        });
      }
    } catch (e) {
      print('Error getting address: ${e.toString()}');
      setState(() {
        _address = 'Address not available';
      });
    }
  }

  void _handleTap(TapPosition tapPosition, LatLng position) {
    setState(() {
      _selectedLocation = position;
      _address = 'Loading address...';
    });

    _getAddressFromCoordinates(position);
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8B0000),
        foregroundColor: Colors.white,
        title: Text(
          S.of(context).selectLocation,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: _selectedLocation ??
                              LatLng(DEFAULT_LAT, DEFAULT_LNG),
                          initialZoom: 15.0,
                          onTap: _handleTap,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                          if (_selectedLocation != null)
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 40.0,
                                  height: 40.0,
                                  point: _selectedLocation!,
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Color(0xFF8B0000),
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      if (_errorMessage != null)
                        Positioned(
                          top: 10,
                          left: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.red.withOpacity(0.7),
                            child: Text(
                              '${S.of(context).locationError}: $_errorMessage\n${S.of(context).tapToSelectLocation}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      // Adding Locate Me Button
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton(
                          heroTag: "locateMe",
                          backgroundColor: Color(0xFF8B0000),
                          tooltip: S.of(context).locateMe,
                          onPressed: _getCurrentLocation,
                          child: Icon(
                            Icons.my_location,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Container(
            padding: EdgeInsets.all(16.w),
            color: dark ? ColorSchemes.darkContainer : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).selectedLocation,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  _address,
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedLocation != null
                        ? () {
                            widget.onLocationSelected(
                              _selectedLocation!.latitude,
                              _selectedLocation!.longitude,
                              _address,
                            );
                            Navigator.pop(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8B0000),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      S.of(context).confirmLocation,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
