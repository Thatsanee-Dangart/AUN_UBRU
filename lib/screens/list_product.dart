import 'dart:async';

import 'package:aun_ubru/models/product_model.dart';
import 'package:aun_ubru/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
//Explicit
//List<String> names=['aa','bb','cc'];  //ประกาศ data type บน dart
  List<DocumentSnapshot> snapshots;
  List<ProductModel> productModels = [];

//Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    //ดึงข้อมูล
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    StreamSubscription<QuerySnapshot> subscription =
        await collectionReference.snapshots().listen((dataSnapshot) {
      snapshots = dataSnapshot.documents;
      for (var mySnapshot in snapshots) {
        String name = mySnapshot.data['Name'];
        String detail = mySnapshot.data['Detail'];
        String path = mySnapshot.data['Path'];
        String qrCode = mySnapshot.data['QRcode'];
        print('name = $name');

        ProductModel productModel = ProductModel(name, detail, path, qrCode);
        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(
        productModels[index].path,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showName(int index) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        productModels[index].name,
        style: TextStyle(fontSize: 30.0, color: Colors.blue.shade900),
      ),
    );
  }

  Widget showDetail(int index) {
    String detail = productModels[index].detail;
    detail = detail.substring(1, 100); //นับตัวอักษร 1-60 การตัดคำ
    detail = '$detail ...';
    Color textColor = Colors.black;
    index % 2 == 0 ? textColor = Colors.black : textColor = Colors.white;
    return Text(
      detail,
      style: TextStyle(color: textColor),
    );
  }

  Widget showText(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: <Widget>[
          showName(index),
          showDetail(index),
        ],
      ),
    );
  }

  Widget showListViewProduct() {
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            decoration: index % 2 == 0
                ? BoxDecoration(color: Colors.blue.shade200)
                : BoxDecoration(color: Colors.blue.shade400), //พื้นหลังไล่สี
            child: Row(
              children: <Widget>[
                showImage(index),
                showText(index),
              ],
            ),
          ),
          onTap: () {
            print('You Click index =$index');
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => Detail(
                productModel: productModels[index],
              ),
            );
            Navigator.of(context).push(materialPageRoute);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return showListViewProduct();
  }
}
