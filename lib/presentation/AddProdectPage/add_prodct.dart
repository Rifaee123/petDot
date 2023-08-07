import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path1;
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petdot/models/pet_details_model.dart';
import 'package:petdot/presentation/AddProdectPage/animated_product.dart';
import 'package:petdot/presentation/AddProdectPage/imageslist.dart';
import 'package:petdot/presentation/HomePage/location_screen/location_page.dart';

class AddProdectPage extends StatefulWidget {
  const AddProdectPage({super.key});

  @override
  State<AddProdectPage> createState() => _AddProdectPageState();
}

class _AddProdectPageState extends State<AddProdectPage> {
  TextEditingController prodectNamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController breadcontroller = TextEditingController();
  var imagePath;
  bool min4image = false;
  List<String> imagelist = [];

  Future<void> addData(PetModel petData) async {
    final user = FirebaseFirestore.instance.collection('user');
    final refrnce = user
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('products');
    refrnce.doc().set({
      'price': petData.price,
      'images': downloadURLs,
      'productname': petData.petname,
      'current Address': addresslocation,
      'Country': contrynamelocation,
      'gender': petData.gender,
      'id': refrnce.id,
      'description': petData.discription,
      'ownerId': FirebaseAuth.instance.currentUser!.displayName,
      'state': stateproduct,
      'breed': breadcontroller.text.trim()
    });

    FirebaseFirestore.instance.collection('allproducts').add({
      'price': petData.price,
      'images': downloadURLs,
      'productname': petData.petname,
      'current Address': addresslocation,
      'Country': contrynamelocation,
      'gender': petData.gender,
      'id': refrnce.id,
      'description': petData.discription,
      'ownerId': FirebaseAuth.instance.currentUser!.displayName,
      'state': stateproduct,
      'breed': breadcontroller.text.trim()
    });
  }

  Future<void> uploadImagesToFirebase(
      List<String> imagePaths, BuildContext context) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    final firebase_storage.Reference storageRef = storage.ref();

    for (String imagePath in imagePaths) {
      final file = File(imagePath);
      final fileName = path1.basename(file.path);
      final firebase_storage.Reference imageRef = storageRef.child(fileName);

      try {
        await imageRef.putFile(file);
        final downloadURL = await imageRef.getDownloadURL();
        downloadURLs.add(downloadURL);
      } catch (error) {
        final snackBar =
            SnackBar(content: Text('Failed to upload image: $error'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    // You can use downloadURLs as needed, for example, you can update the Firestore document with the download URLs.
    // For demonstration purposes, let's just print the download URLs.
    downloadURLs.forEach((url) => print('Download URL: $url'));
  }

  void removeImageAtIndex(int index) {
    setState(() {
      imagelist.removeAt(index);
    });
  }

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    setState(() {
      downloadURLs.length < 4 ? min4image = true : false;
    });
    print(downloadURLs.length);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset(
                        "assets/images/back.jpg",
                        width: 350.w,
                      ),
                    ),
                    Image.asset(
                      "assets/images/icons8-shopping-cart-promotion-100.png",
                      width: 350.w,
                    ),
                    Text(
                      "Add Pet",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // Stack(children: [
              //   CircleAvatar(
              //     radius: 90,
              //     backgroundImage: imagePath == null
              //         ? AssetImage(
              //             'assets/images/martina-round-icon-with-a-person.gif',
              //           ) as ImageProvider
              //         : FileImage(File(imagePath!)),
              //   ),
              //   Positioned(
              //       bottom: 20,
              //       right: 10,
              //       child: Container(
              //           width: 360.w,
              //           decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(30))),
              //           child: InkWell(
              //               onTap: () {
              //                 Navigator.of(context).push(MaterialPageRoute(
              //                   builder: (context) => ImagesList(),
              //                 ));
              //               },
              //               child: Image.asset(
              //                   "assets/images/icons8-photos-50.png"))))
              // ]),
              CarouselSlider.builder(
                itemCount: imagelist.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Container(
                    // width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Stack(
                      children: [
                        Image(
                          image: FileImage(File(imagelist[index])),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Color(0xff95f8e4),
                            child: IconButton(
                              onPressed: () {
                                removeImageAtIndex(index);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                carouselController: _controller,
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  initialPage: 1,
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color(0xff95f8e4))),
                  onPressed: () {
                    takePhoto().then((value) {
                      if (imagelist.length < 4) {
                        imagelist.add(imagePath!);
                        uploadImagesToFirebase(imagelist, context);
                      }
                    });
                  },
                  child: Text('Add Image')),

              Text(
                "*Minimum 4 images Required",
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 230),
                child: Text("Product Name",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 1850.w,
                height: 70.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Color(0x00d9d9d9)),
                child: TextFormField(
                  controller: prodectNamecontroller,
                  decoration: InputDecoration(
                      hintText: "Add Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 230),
                child: Text("Discription",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 1850.w,
                height: 70.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Color(0x00d9d9d9)),
                child: TextFormField(
                  controller: descriptioncontroller,
                  decoration: InputDecoration(
                      hintText: "Add Discription",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
              ),
              SizedBox(
                height: 10.h,
                width: double.infinity,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text("Age",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        Container(
                          width: 400.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Color(0x00d9d9d9)),
                          child: TextFormField(
                            controller: agecontroller,
                            decoration: InputDecoration(
                                hintText: "Age",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)))),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Price"),
                  ),
                  Column(
                    children: [
                      Text(""),
                      Container(
                        width: 1200.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Color(0x00d9d9d9)),
                        child: TextFormField(
                          controller: pricecontroller,
                          decoration: InputDecoration(
                              hintText: "Price",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)))),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 250),
                child: Text("gender",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 1850.w,
                height: 70.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Color(0x00d9d9d9)),
                child: TextFormField(
                  controller: gendercontroller,
                  decoration: InputDecoration(
                      hintText: "Add Gender",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 270),
                child: Text("Bread",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 1850.w,
                height: 70.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Color(0x00d9d9d9)),
                child: TextFormField(
                  controller: breadcontroller,
                  decoration: InputDecoration(
                      hintText: "Add bread",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                    onPressed: () {
                      getlocation().then((value) {
                        lat = '${value.latitude}';
                        long = '${value.longitude}';
                        // setState(() {
                        //   locationMassage = 'latitude:$lat,longitude :$long';
                        // });
                        liveLocation();
                      });
                      openmap(lat, long);
                    },
                    child: Row(
                      children: [
                        Text('Current location'),
                        Icon(Icons.location_on_sharp)
                      ],
                    )),
              ),
              Text(
                  "${addresslocation} , ${stateproduct},${contrynamelocation}"),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 1247.w,
                height: 80.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4FF9D9), // background
                    foregroundColor: Colors.black, // foreground
                  ),
                  onPressed: () async {
                    print(downloadURLs.length);

                    if (downloadURLs.length > 3) {
                      return addData(PetModel(
                              address: featuname,
                              contry: contryname,
                              discription: descriptioncontroller.text.trim(),
                              gender: gendercontroller.text.trim(),
                              petname: prodectNamecontroller.text.trim(),
                              price: int.parse(pricecontroller.text.trim())))
                          .then((value) {
                        log('data added suscessfully');
                        setState(() {});
                        imagelist.clear();
                        downloadURLs.clear();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AddScreen(),
                        ));
                      });
                    } else {
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Add minimum'),
                            content: Text('minimum 4 images requard'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Close the alert dialog
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }

                    // Get.snackbar(
                    //     'added suscesfully', 'your product added on petDot');
                  },
                  child: Text(
                    'Add Product',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchCurrentlocation() async {}

  void liveLocation() {
    LocationSettings locationsettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationsettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      // setState(() {
      //   locationMassage = 'latitude:$lat,longitude :$long';
      // });
    });
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

  void openmap(String lat, String long) async {
    final coordinates = new Coordinates(double.parse(lat), double.parse(long));
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final first = addresses.first;
    setState(() {
      addresslocation = first.featureName;
      contrynamelocation = first.countryName;
      stateproduct = first.adminArea;
    });

    print(
        "${addresslocation} : ad${first.addressLine}ad :${contrynamelocation}");
  }

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }
}

var addresslocation;
var contrynamelocation;
var stateproduct;
var lat;
var long;
