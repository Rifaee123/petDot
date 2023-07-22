import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petdot/presentation/HomePage/Home.dart';

class MyAdsPage extends StatelessWidget {
  const MyAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference user = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('products');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (.3 / .5), crossAxisCount: 2),
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
                return Text("no data");
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
      ),
    );
  }
}
