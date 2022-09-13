import 'package:flutter/material.dart';

class Product {
  dynamic id;
  String? title;
  String? img;
  String? description;
  int? price;
  String? subtitle;
  dynamic userID;
  int? productCount = 0;
  bool? isLiked;
  String? orderDateTime ;
  int?totalPrice;

      

  Product({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.img,
    this.price,
    this.userID,
    this.productCount = 0,
    this.isLiked,
    this.orderDateTime,
    this.totalPrice,
  });

  Product.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    img = map['img'];
    description = map['description'];
    price = map['price'];
    subtitle = map['subtitle'];
    userID = map['userID'];
    productCount = map['productCount'];
    isLiked = map['isLiked'];
    orderDateTime = map['orderDateTime'];
    totalPrice=map['totalPrice'];
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'img': img,
      'description': description,
      'price': price,
      'subtitle': subtitle,
      'userID': userID,
      'productCount': productCount,
      'isLiked': isLiked,
      'orderDateTime': orderDateTime,
      'totalPrice':totalPrice,
    };
  }
}
