import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:work_1/model_cart.dart';

class HomeController extends GetxController {
  List<Model_cart> cartList = [];

  addToCart(Model_cart model_cart) {
    cartList.add(model_cart);
    update();
  }

  removeFromCart(int index) {
    cartList.removeAt(index);
    update();
  }

  incrementQuantity(int index) {
    cartList[index].quantity++;
    update();
  }

  decrementQuantity(int index) {
    cartList[index].quantity--;
    update();
  }

  //var netTotal;
  //var totalSum;
  var netTotal;

  void getTotal() {
    netTotal = cartList
        .map((item) => item.price!.toInt() * item.quantity)
        .reduce((value, element) => value + element);
    update();
  }
}
