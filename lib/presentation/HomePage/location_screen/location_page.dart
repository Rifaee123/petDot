// import 'package:csc_picker/csc_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_geocoder/geocoder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';

// String? mainAdress;

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({
//     super.key,
//   });

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   String? countryValue = "";
//   String? stateValue = "";
//   String? cityValue = "";
//   String? address = "";
//   String? fetchaddress;
//   late String lat;
//   late String long;
//   String locationMassage = 'no value';
//   Future<Position> getlocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('location service are disebled');
//     }
//     LocationPermission permission = await Geolocator.checkPermission();
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }

//   // Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   // Future<Position> determinePosition() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;

//   //   // Test if location services are enabled.
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     // Location services are not enabled don't continue
//   //     // accessing the position and request users of the
//   //     // App to enable the location services.
//   //     return Future.error('Location services are disabled.');
//   //   }

//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       // Permissions are denied, next time you could try
//   //       // requesting permissions again (this is also where
//   //       // Android's shouldShowRequestPermissionRationale
//   //       // returned true. According to Android guidelines
//   //       // your App should show an explanatory UI now.
//   //       return Future.error('Location permissions are denied');
//   //     }
//   //   }

//   //   if (permission == LocationPermission.deniedForever) {
//   //     // Permissions are denied forever, handle appropriately.
//   //     return Future.error(
//   //         'Location permissions are permanently denied, we cannot request permissions.');
//   //   }

//   //   // When we reach here, permissions are granted and we can
//   //   // continue accessing the position of the device.
//   //   return await Geolocator.getCurrentPosition();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     showbottem(Context) {
//       showModalBottomSheet(
//         isScrollControlled: true,
//         enableDrag: true,
//         context: context,
//         builder: (context) {
//           return SafeArea(
//             child: Column(
//               children: [
//                 AppBar(
//                   automaticallyImplyLeading: false,
//                   title: Row(children: [
//                     IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(Icons.close)),
//                     Text('Location')
//                   ]),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.all(Radius.circular(6))),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                           hintText: 'Search city,area or neghbourhood',
//                           icon: Icon(Icons.search)),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     getlocation().then((value) {
//                       lat = '${value.latitude}';
//                       long = '${value.longitude}';
//                       setState(() {
//                         locationMassage = 'latitude:$lat,longitude :$long';
//                       });
//                       liveLocation();
//                     });
//                     fetchaddress = openmap(lat, long);
//                     setState(() {
//                       address = fetchaddress.toString();
//                     });
//                   },
//                   leading: Icon(
//                     Icons.my_location,
//                     color: Colors.blue,
//                   ),
//                   title: Text('Use Current Location'),
//                   subtitle: Text(fetchaddress.toString()),
//                 ),
//                 Text("${featuname} : ${adressline}:${contryname}"),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       CSCPicker(
//                         showCities: true,
//                         showStates: true,
//                         defaultCountry: CscCountry.India,

//                         currentCountry: 'india',
//                         layout: Layout.vertical,
//                         dropdownDecoration:
//                             BoxDecoration(shape: BoxShape.rectangle),

//                         // style: TextStyle(color: Colors.red),
//                         onCountryChanged: (value) {
//                           setState(() {
//                             countryValue = value;
//                           });
//                         },
//                         onStateChanged: (value) {
//                           setState(() {
//                             stateValue = value;
//                           });
//                         },
//                         onCityChanged: (value) {
//                           setState(() {
//                             cityValue = value;
//                           });
//                           address = '$cityValue,$stateValue,$countryValue';
//                         },
//                       ),
//                       SizedBox(height: 20.h),
//                       InkWell(
//                           onTap: () {
//                             print(address);
//                             print('country selected is $countryValue');
//                             print('country selected is $stateValue');
//                             print('country selected is $cityValue');
//                           },
//                           child: Text(' Check'))
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       );
//     }

//     return SafeArea(
//         child: Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(locationMassage),
//             ElevatedButton(
//                 onPressed: () {
//                   getlocation().then((value) {
//                     lat = '${value.latitude}';
//                     long = '${value.longitude}';
//                     setState(() {
//                       locationMassage = 'latitude:$lat,longitude :$long';
//                     });
//                     liveLocation();
//                   });
//                   // determinePosition();
//                 },
//                 child: Text('get location')),
//             Text(featuname == null ? 'no data' : featuname),
//             TextButton(
//                 onPressed: () {
//                   showbottem(context);
//                 },
//                 child: Text('location manually')),
//             Text(address.toString()),
//           ],
//         ),
//       ),
//     ));
//   }

//   void liveLocation() {
//     LocationSettings locationsettings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 100,
//     );
//     Geolocator.getPositionStream(locationSettings: locationsettings)
//         .listen((Position position) {
//       lat = position.latitude.toString();
//       long = position.longitude.toString();
//       setState(() {
//         locationMassage = 'latitude:$lat,longitude :$long';
//       });
//     });
//     openmap(lat, long);
//   }

//   openmap(String lat, String long) async {
//     final coordinates = new Coordinates(double.parse(lat), double.parse(long));
//     final addresses =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     final first = addresses.first;
//     setState(() {
//       featuname = first.featureName;
//       contryname = first.countryName;
//       adressline = first.addressLine;
//     });

//     print("${featuname} : ${first.addressLine}:${contryname}");
//   }
// }

var adressline;
var featuname;
var contryname;
