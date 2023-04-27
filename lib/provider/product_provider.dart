// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shopin_app/model/cartmodel.dart';
import 'package:shopin_app/model/product.dart';
import 'package:shopin_app/model/usermodel.dart';

class ProductProvider with ChangeNotifier {
  List<Product> feature = [];
  Product? featureData;

  List<CartModel> checkOutModelList = [];
  CartModel? checkOutModel;
  List<UserModel> userModelList = [];
  UserModel? userModel;
  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot =
        await FirebaseFirestore.instance.collection("User").get();
    for (var element in userSnapShot.docs) {
      // if (currentUser!.uid == element.data()["UserId"]) {
      //   userModel = UserModel(
      //       userAddress: element.data()["userAddress"],
      //       userImage: element.data()["userImage"],
      //       userEmail: element.data()["userEmail"],
      //       userGender: element.data()["userGender"],
      //       userName: element.data()["UserName"],
      //       userPhoneNumber: element.data()["UserNumber"]);
      //   newList.add(userModel!);
      // }
      userModelList = newList;
    }
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

  void deleteCheckoutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }

  void clearCheckoutProduct() {
    checkOutModelList.clear();
    notifyListeners();
  }

  void getCheckOutData({
    int? quantity,
    double? price,
    String name = "",
    String color = "",
    String size = "",
    String image = "",
  }) {
    checkOutModel = CartModel(
      color: color,
      size: size,
      price: price!,
      name: name,
      image: image,
      quantity: quantity!,
    );
    checkOutModelList.add(checkOutModel!);
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  int get getCheckOutModelListLength {
    return checkOutModelList.length;
  }

  Future<void> getFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("hfPmMokn0tbAuGZvRMy1")
        .collection("featureproduct")
        .get();
    for (var element in featureSnapShot.docs) {
      // featureData = Product(
      //     image: element.data()["image"],
      //     name: element.data()["name"],
      //     price: element.data()["price"]);
      // newList.add(featureData!);
    }
    feature = newList;
  }

  List<Product> get getFeatureList {
    return feature;
  }

  List<Product> homeFeature = [];

  Future<void> getHomeFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("homefeature").get();
    for (var element in featureSnapShot.docs) {
      // featureData = Product(
      //     image: element.data()["image"],
      //     name: element.data()["name"],
      //     price: element.data()["price"]);
      // newList.add(featureData!);
    }
    homeFeature = newList;
    notifyListeners();
  }

  List<Product> get getHomeFeatureList {
    return homeFeature;
  }

  List<Product> homeArchive = [];

  Future<void> getHomeAchiveData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("homeachive").get();
    for (var element in featureSnapShot.docs) {
      // featureData = Product(
      //     image: element.data()["image"],
      //     name: element.data()["name"],
      //     price: element.data()["price"]);
      // newList.add(featureData!);
    }
    homeArchive = newList;
    notifyListeners();
  }

  List<Product> get getHomeArchiveList {
    return homeArchive;
  }

  List<Product> newArchives = [];
  Product? newArchivesData;
  Future<void> getNewArchiveData() async {
    List<Product> newList = [];
    QuerySnapshot archivesSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("hfPmMokn0tbAuGZvRMy1")
        .collection("newachives")
        .get();
    for (var element in archivesSnapShot.docs) {
      // newArchivesData = Product(
      //     image: element.data()["image"],
      //     name: element.data()["name"],
      //     price: element.data()["price"]);
      // newList.add(newArchivesData!);
    }
    newArchives = newList;
    notifyListeners();
  }

  List<Product> get getNewArchivesList {
    return newArchives;
  }

  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  get getNotificationList {
    return notificationList;
  }

  List<Product>? searchList;
  void getSearchList({List<Product>? list}) {
    searchList = list;
  }

  List<Product> searchProductList(String query) {
    List<Product> searchShirt = searchList!.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchShirt;
  }
}
