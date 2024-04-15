import 'package:evreka_app/ui/views/google_map/component/container_info_widget.dart';
import 'package:evreka_app/ui/views/google_map/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends ConsumerStatefulWidget {
  const GoogleMapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends ConsumerState<GoogleMapView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(mapProvider).setContainerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = ref.read(mapProvider);
    final watch = ref.watch(mapProvider);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: read.kGooglePlex,
            onMapCreated: read.onMapCreated,
            markers: watch.markers,
            minMaxZoomPreference: read.minMaxZoom,
            onTap: (LatLng latLng) {
              if (watch.isChangeMarker) {
                read.setNewLocation(latLng);
              } else {
                read.unselectedMarker();
              }
            },
          ),
          if (watch.activeContainer != null) ...[
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ContainerInfoWidget(),
            ),
          ],
        ],
      ),
    );
  }
}
