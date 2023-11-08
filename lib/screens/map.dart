import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng currentLocation = LatLng(-20.348404, 57.552151);

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  late BitmapDescriptor treeIcon;
  late BitmapDescriptor plantIcon;

  @override
  void initState() {
    super.initState();
    setMarkerIcon();
  }

  void setMarkerIcon() async {
    treeIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(0.1, 0.1)),
      "assets/images/tree2.png",
    );

    plantIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(0.01, 0.01)),
      "assets/images/plantshop6.png",
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GoogleMap(
          initialCameraPosition:
              const CameraPosition(target: currentLocation, zoom: 12),
          markers: {
            Marker(
              markerId: const MarkerId("marker1"),
              position: const LatLng(-20.141216244925424, 57.50316814160898),
              draggable: true,
              onDragEnd: (value) {},
              icon: treeIcon,
              infoWindow: InfoWindow(
                title: "Nature Park",
                snippet: "Rivulet Terre Rouge Estuary Bird Sanctuary",
                onTap: () {
                  // Handle info window tap
                },
              ),
            ),
            Marker(
              markerId: const MarkerId("marker2"),
              position: const LatLng(-20.104476, 57.580304),
              draggable: true,
              onDragEnd: (value) {},
              icon: treeIcon,
              infoWindow: InfoWindow(
                title: "Nature Park",
                snippet: "SSR Botanical Garden",
                onTap: () {
                  // Handle info window tap
                },
              ),
            ),
            Marker(
              markerId: const MarkerId("marker3"),
              position: const LatLng(-20.500578054996694, 57.44141612944415),
              draggable: true,
              onDragEnd: (value) {},
              icon: treeIcon,
              infoWindow: InfoWindow(
                title: "Nature Park",
                snippet: "Bel Ombre Nature Reserve",
                onTap: () {
                  // Handle info window tap
                },
              ),
            ),
            Marker(
              markerId: const MarkerId("marker4"),
              position: const LatLng(-20.45743306067168, 57.485607153445365),
              draggable: true,
              onDragEnd: (value) {},
              icon: treeIcon,
              infoWindow: InfoWindow(
                title: "Nature Park",
                snippet: "La Vallée Des Couleurs Nature Park",
                onTap: () {
                  // Handle info window tap
                },
              ),
            ),
            Marker(
              markerId: const MarkerId("marker5"),
              position: const LatLng(-20.48356986256213, 57.47144688698643),
              draggable: true,
              onDragEnd: (value) {},
              icon: treeIcon,
              infoWindow: InfoWindow(
                title: "Nature Park",
                snippet: "Chazal Ecotourism",
                onTap: () {
                  // Handle info window tap
                },
              ),
            ),
            Marker(
              markerId: const MarkerId("marker6"),
              position: const LatLng(-20.42484240163827, 57.451373169367336),
              draggable: true,
              onDragEnd: (value) {},
              icon: treeIcon,
              infoWindow: InfoWindow(
                title: "Nature Park",
                snippet: "Black River Gorges Nature Park",
                onTap: () {
                  // Handle info window tap
                },
              ),
            ),
            Marker(
              markerId: const MarkerId("marker7"),
              position: const LatLng(-20.239422768276334, 57.47991361787242),
              draggable: true,
              onDragEnd: (value) {},
              icon: treeIcon,
              infoWindow: InfoWindow(
                title: "Nature Park",
                snippet: "Ebene Recreational Park",
                onTap: () {
                  // Handle info window tap
                },
              ),
            ),
            Marker(
              markerId: const MarkerId("marker8"),
              position: const LatLng(-20.281067534948527, 57.460443923831654),
              draggable: true,
              onDragEnd: (value) {},
              icon: plantIcon,
              infoWindow: InfoWindow(
                title: "Plant Shop",
                snippet: "Serre de Palma",
                onTap: () {
                  // Handle info window tap
                },
              ),
            ),
            Marker(
              markerId: const MarkerId("marker9"),
              position: const LatLng(-20.261377363081053, 57.49486742219945),
              draggable: true,
              onDragEnd: (value) {},
              icon: plantIcon,
              infoWindow: InfoWindow(
                title: "Plant Shop",
                snippet: "Vaneron Garden Centre",
                onTap: () {
                  // Handle info window tap
                },
              ),
            ),
            Marker(
              markerId: const MarkerId("marker10"),
              position: const LatLng(-20.29393312016071, 57.47942282382148),
              draggable: true,
              onDragEnd: (value) {},
              icon: plantIcon,
              infoWindow: InfoWindow(
                title: "Plant Shop",
                snippet: "Tropical Orchids",
                onTap: () {
                  // Handle info window tap
                },
              ),
            ),
          },
        ),
      ),
    );
  }
}
