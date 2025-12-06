import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' show locationFromAddress;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../bloodbanks/presentation/manager/getBloodBankcubit/getbloodbank_cubit.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Set<Marker> markers = {};
  LatLng? firstLocation;

  Future<void> _generateMarkers(bloodBanks) async {
    markers.clear();

    for (var bank in bloodBanks) {
      try {
        final locations = await locationFromAddress(bank.address);

        if (locations.isNotEmpty) {
          final pos = LatLng(locations.first.latitude, locations.first.longitude);

          markers.add(Marker(
            markerId: MarkerId(bank.name),
            position: pos,
            infoWindow: InfoWindow(
              title: bank.name,
              snippet: bank.phone,
            ),
          ));

          firstLocation ??= pos;
        }
      } catch (e) {
        print("Error for ${bank.address}: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blood Banks on Map")),

      body: BlocBuilder<GetBloodBankCubit, GetBloodBankState>(
        builder: (context, state) {

          if (state is GetBloodBankLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetBloodBankFailure) {
            return Center(child: Text(state.errMessages));
          }

          if (state is GetBloodBankSuccess) {
            return FutureBuilder(
              future: _generateMarkers(state.bloodBanks),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: firstLocation ?? const LatLng(30.0444, 31.2357),
                    zoom: 12,
                  ),
                  markers: markers,
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
