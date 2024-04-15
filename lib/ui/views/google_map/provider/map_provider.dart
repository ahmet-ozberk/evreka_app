// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evreka_app/ui/components/base_popup/error_popup.dart';
import 'package:evreka_app/ui/components/base_popup/loading_popup.dart';
import 'package:evreka_app/ui/views/google_map/component/marker_widget.dart';
import 'package:evreka_app/ui/views/google_map/model/container_model.dart';
import 'package:evreka_app/ui/views/google_map/model/update_location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final mapProvider = ChangeNotifierProvider((ref) => MapProvider());

class MapProvider extends ChangeNotifier {
  final provider = ProviderContainer();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(39.9486, 32.8995),
    zoom: 4,
  );
  LatLng? newLocation;
  final Set<Marker> _markers = {};
  final List<ContainerModel> _containerList = [];
  final minMaxZoom = const MinMaxZoomPreference(5, 24);
  bool isChangeMarker = false;
  ContainerModel? _activeContainer;

  CameraPosition get kGooglePlex => _kGooglePlex;
  Completer<GoogleMapController> get controller => _controller;
  Set<Marker> get markers => _markers;
  List<ContainerModel> get containerList => _containerList;
  MinMaxZoomPreference get minMaxZoomPreference => minMaxZoom;
  ContainerModel? get activeContainer => _activeContainer;

  set activeContainer(ContainerModel? value) {
    _activeContainer = value;
    notifyListeners();
  }

  void setContainerList() async {
    _containerList.clear();
    await provider
        .read(getContainersProvider)
        .then((value) => _containerList.addAll(value));
    addMarker();
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    notifyListeners();
  }

  Future<void> updateLocation(UpdateLocationModel updateModel) async {
    await provider.read(updateLocationProvider(updateModel));
    markers.clear();
    setContainerList();
  }

  Future<BitmapDescriptor> get activeIcon async {
    return await MarkerWidget.getIcon(isActive: true);
  }

  Future<BitmapDescriptor> get defaultIcon async {
    return await MarkerWidget.getIcon();
  }

  Future<BitmapDescriptor> get loseActiveIcon async {
    return await MarkerWidget.getIcon(isActive: true, opacity: 0.3);
  }

  ContainerModel? get activeMarkerModel {
    if (_activeContainer != null) {
      return _containerList.firstWhere(
        (element) => element.containerId == _activeContainer?.containerId,
        orElse: () => ContainerModel(),
      );
    }
    return null;
  }

  Future<void> addMarker() async {
    _containerList.forEach((element) async {
      final marker = Marker(
        markerId: MarkerId(element.containerId ?? ""),
        position: LatLng(element.latitude!, element.longitude!),
        icon: await defaultIcon,
        onTap: () async {
          markerPress(element);
        },
      );
      _markers.add(marker);
      notifyListeners();
    });
  }

  Future<void> markerPress([ContainerModel? model]) async {
    if(_activeContainer?.containerId == model?.containerId) return;
    LoadingPopup.show();
    if (_activeContainer == null) {
      _activeContainer = model;
      markers
          .add(await changeMarker(icon: activeIcon, model: _activeContainer));
      notifyListeners();
    } else {
      markers.add(await changeMarker(icon: defaultIcon, model: model));
      _activeContainer = null;
      markerPress(model);
    }
    LoadingPopup.hide();
  }

  Future<Marker> changeMarker(
      {required Future<BitmapDescriptor> icon, ContainerModel? model}) async {
    markers.removeWhere(
        (element) => element.markerId.value == _activeContainer?.containerId);
    final ltLng = LatLng(
      _activeContainer?.latitude ?? 0,
      _activeContainer?.longitude ?? 0,
    );
    final marker = Marker(
      markerId: MarkerId(_activeContainer?.containerId ?? ""),
      position: ltLng,
      icon: await icon,
      onTap: () {
        markerPress(model);
      },
    );
    return marker;
  }

  Future<void> unselectedMarker() async {
    if (_activeContainer != null) {
      markers.add(await changeMarker(icon: defaultIcon, model: _activeContainer));
      _activeContainer = null;
      notifyListeners();
    }
  }

  Future<void> clearMarkers() async {
    _markers.clear();
    _markers.add(await changeMarker(icon: activeIcon, model: _activeContainer));
    isChangeMarker = true;
    notifyListeners();
  }

  Future<void> setNewLocation(LatLng location) async {
    newLocation = null;
    markers.removeWhere((element) => element.markerId.value == "newLocation");
    newLocation = location;
    markers.add(Marker(
      markerId: const MarkerId("newLocation"),
      position: location,
      icon: await activeIcon,
    ));
    markers
        .add(await changeMarker(icon: loseActiveIcon, model: activeContainer));
    notifyListeners();
  }

  Future<void> saveLocation() async {
    if (_activeContainer != null &&
        isChangeMarker == true &&
        newLocation != null) {
          LoadingPopup.show();
      _activeContainer = _activeContainer!.copyWith(
        latitude: newLocation!.latitude,
        longitude: newLocation!.longitude,
      );
      await updateLocation(UpdateLocationModel(
        containerId: _activeContainer!.containerId!,
        latitude: newLocation!.latitude,
        longitude: newLocation!.longitude,
      ));
      isChangeMarker = false;
      newLocation = null;
      activeContainer = null;
      notifyListeners();
      LoadingPopup.hide();
    }
  }
}

final getContainersProvider = Provider((ref) async {
  try {
    LoadingPopup.show();
    final firebaseStore = FirebaseFirestore.instance;
    final data = await firebaseStore.collection('containers').get();
    dev.log("İd: ${data.docs.first.id}");
    final list = data.docs.first.data()['containers'] as List;
    final List<ContainerModel> containerList = list
        .map((e) =>
            ContainerModel.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
    LoadingPopup.hide();
    return containerList;
  } catch (e) {
    LoadingPopup.hide();
    ErrorPopup.show(e.toString());
    return <ContainerModel>[];
  }
});

final updateLocationProvider =
    Provider.family((ref, UpdateLocationModel updateModel) async {
  try {
    final firebaseStore = FirebaseFirestore.instance;
    final containerList = await ref.read(getContainersProvider);
    final docId = firebaseStore.collection('containers').doc().id;
    final index = containerList.indexWhere(
        (element) => element.containerId == updateModel.containerId);
    containerList[index] = containerList[index].copyWith(
      latitude: updateModel.latitude,
      longitude: updateModel.longitude,
    );

    await firebaseStore.collection('containers').doc(docId).set({
      'containers': containerList.map((e) => jsonEncode(e.toJson())).toList(),
    });
  } catch (e) {
    dev.log(e.toString());
  }
});


/*
final fakeDataAdd = Provider((ref) async {
  final random = Random();
  final firebaseStore = FirebaseFirestore.instance;
  final list = <ContainerModel>[];
  for (var i = 0; i < 1111; i++) {
    double nextDouble(num min, num max) =>
        min + random.nextDouble() * (max - min);
    double randomLat = nextDouble(-90, 90);
    double randomLng = nextDouble(-180, 180);
    final randomSendowId = DateTime.now().millisecondsSinceEpoch.toString() +
        i.toString() +
        random.nextInt(1000).toString();
      await Future.delayed(const Duration(milliseconds: 20));
    final randomContainerId = DateTime.now().millisecondsSinceEpoch.toString() +
        i.toString() +
        random.nextInt(1000).toString();

    final randomDate = DateTime.utc(
      random.nextInt(13) + 2011,
      random.nextInt(12) + 1,
      random.nextInt(30) + 1,
    );
    final randomPercentage = random.nextInt(100);
    final randomTemperature = random.nextInt(100).toString();
    final randomLocation = GeoPoint(randomLat, randomLng);

    final container = ContainerModel(
      containerId: randomContainerId,
      sensorId: randomSendowId,
      date: randomDate.toString(),
      percentage: randomPercentage.toString(),
      longitude: randomLocation.longitude,
      latitude: randomLocation.latitude,
      temperature: randomTemperature,
    );
    list.add(container);
  }
  
  await firebaseStore.collection('containers').add({
    'containers': list.map((e) => jsonEncode(e.toJson())).toList(),
  }).then((value) {
    print("value $value");
  }).catchError((err) {
    print("err $err");
  });
});

*/