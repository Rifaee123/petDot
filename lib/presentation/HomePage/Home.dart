import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petdot/presentation/AddProdectPage/add_prodct.dart';
import 'package:petdot/presentation/AddProdectPage/imageslist.dart';
import 'package:petdot/presentation/AuthPage/signin_or_signup.dart';
import 'package:petdot/presentation/HomePage/location_screen/location_page.dart';

String? mainadress;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";
  String? fetchaddress;
  final CollectionReference user =
      FirebaseFirestore.instance.collection('allproducts');
  int currentindex = 0;
  String locationMassage = 'no value';
  showbottem(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: Row(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                  Text('Location')
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Search city,area or neghbourhood',
                        icon: Icon(Icons.search)),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  getlocation().then((value) {
                    lat = '${value.latitude}';
                    long = '${value.longitude}';
                    setState(() {
                      locationMassage = 'latitude:$lat,longitude :$long';
                    });
                    liveLocation();
                  });
                  setState(() {
                    mainadress = adressline.toString();
                  });
                },
                leading: Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ),
                title: Text('Use Current Location'),
                subtitle: Text("${adressline}"),
              ),
              Text('Choose Location'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CSCPicker(
                      showCities: true,
                      showStates: true,
                      defaultCountry: CscCountry.India,
                      flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                      currentCountry: 'india',
                      layout: Layout.vertical,
                      dropdownDecoration:
                          BoxDecoration(shape: BoxShape.rectangle),

                      // style: TextStyle(color: Colors.red),
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                        setState(() {
                          mainadress = '$cityValue,$stateValue,$countryValue';
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                        onTap: () {
                          print(address);
                          print('country selected is $countryValue');
                          print('country selected is $stateValue');
                          print('country selected is $cityValue');
                        },
                        child: Text(' Check')),
                    Text(mainadress.toString())
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 700,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/HomeBack.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            getlocation().then((value) {
                              lat = '${value.latitude}';
                              long = '${value.longitude}';
                              setState(() {
                                locationMassage =
                                    'latitude:$lat,longitude :$long';
                              });
                              liveLocation();
                            }).then((value) => showbottem(context));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                featuname ?? "kottyam",
                                style: const TextStyle(fontSize: 15),
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text(
                                    "kerala,india",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          child: Image.asset(
                            "assets/images/icons8-add-100.png",
                            width: 350.w,
                          ),
                          onTap: () {
                            setState(() {
                              downloadURLs.clear();
                            });

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddProdectPage(),
                            ));
                          },
                        ),
                        InkWell(
                          child: Image.asset(
                            "assets/images/icons8-favorites-100 (1).png",
                            width: 350.w,
                          ),
                          onTap: () {},
                        ),
                        // assets\images\icons8-notification.gif
                        InkWell(
                          child: Image.asset(
                            "assets/images/icons8-notification-100.png",
                            width: 350.w,
                          ),
                          onTap: () {
                            FirebaseAuth.instance.signOut().then((value) =>
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const SigninOrSignup(),
                                )));
                            GoogleSignIn().signOut();
                          },
                        ),
                        // IconButton(
                        //     icon: const Icon(
                        //       Icons.notifications,
                        //       size: 35,
                        //     ),
                        //     onPressed: () {
                        //       FirebaseAuth.instance.signOut().then((value) =>
                        //           Navigator.of(context)
                        //               .pushReplacement(MaterialPageRoute(
                        //             builder: (context) => SigninOrSignup(),
                        //           )));
                        //       GoogleSignIn().signOut();
                        //     })
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      width: 1800.w,
                      height: 60.h,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "browse catogary",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(
                          width: 200.w,
                        ),
                        const Text(
                          'See All',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentindex = 0;
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/icons8-animal-shelter-100.png",
                                width: 600.w,
                              ),
                              const Text("All Pets")
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentindex = 1;
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/icons8-cat-100.png",
                                width: 600.w,
                              ),
                              const Text("cat")
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentindex = 2;
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/icons8-dog-100.png",
                                width: 600.w,
                              ),
                              const Text("Dog")
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Container(
                    //     width: double.infinity,
                    //     height: 5.h,
                    //     decoration: const BoxDecoration(color: Color(0xff95f8e4))),
                    Divider(
                      height: 5.h,
                      color: Color(0xff95f8e4),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 100),
                      child: Text("Fresh Recommendations",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          )),
                    ),
                    IndexedStack(
                      index: currentindex,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder(
                            stream: user.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                log('snapshot.data.toString()');
                                log(snapshot.data.toString());
                                return GridView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: (.3 / .5),
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot userSnap =
                                        snapshot.data!.docs[index];
                                    return prodectCard(
                                        price: userSnap['price'],
                                        petName: userSnap['productname'],
                                        location: userSnap['current Address'],
                                        gender: userSnap['gender'],
                                        imageUrl: userSnap['images'][0]);
                                  },
                                );
                              } else {
                                return Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.red,
                                );
                                //  Center(
                                //   child: Image.asset(
                                //       'assets/images/techny-purchased-items-on-sale.gif'),
                                // );
                                // return GridView.builder(
                                //   itemCount: 4,
                                //   physics: const NeverScrollableScrollPhysics(),
                                //   shrinkWrap: true,
                                //   gridDelegate:
                                //       const SliverGridDelegateWithFixedCrossAxisCount(
                                //           childAspectRatio: (.3 / .5),
                                //           crossAxisCount: 2),
                                //   itemBuilder: (context, index) {
                                //     return prodectCard(
                                //       price: 17000,
                                //       petName: 'Persian-Cat-For-Sell',
                                //       location: 'kottayam',
                                //       gender: 'female',
                                //       imageUrl: "assets/images/cat1.jpg",
                                //     );
                                //   },
                                // );
                              }
                            },
                          ),
                        ),
                        Text('cAt'),
                        Text('dog')
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> getlocation() async {
    
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('location service are disebled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void liveLocation() {
    LocationSettings locationsettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationsettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      setState(() {
        locationMassage = 'latitude:$lat,longitude :$long';
      });
    });
    openmap(lat, long);
  }

  openmap(String lat, String long) async {
    final coordinates = new Coordinates(double.parse(lat), double.parse(long));
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final first = addresses.first;
    setState(() {
      featuname = first.featureName;
      contryname = first.countryName;
      adressline = first.addressLine;
    });

    print("${featuname} : ${first.addressLine}:${contryname}");
  }
}

// }

class prodectCard extends StatelessWidget {
  const prodectCard({
    super.key,
    required this.price,
    required this.petName,
    required this.location,
    required this.gender,
    required this.imageUrl,
  });
  final int price;
  final String petName;
  final String location;
  final String gender;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1)
            ],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              width: 791.w,
              height: 160.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("₹$price/-",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
              ],
            ),
            Text(petName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                )),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/icons8-location-50.png",
                      width: 260.w,
                      height: 26.h,
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/icons8-cat-16.png",
                      width: 260.w,
                      height: 26.h,
                    ),
                    Text(gender)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
