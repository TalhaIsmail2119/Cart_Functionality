import 'package:flutter/material.dart';
import 'package:work_1/home_page_controller.dart';
import 'package:work_1/model_cart.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  HomeController homeController = Get.put(HomeController());

  var netTotal;

  void getTotal() {
    netTotal = homeController.cartList
        .map((item) => item.price!.toInt() * item.quantity)
        .reduce((value, element) => value + element);
  }

  @override
  void initState() {
    // TODO: implement initState
    homeController.cartList.length > 0 ? getTotal() : null;
    //print("ikhdfdasgasiuasgifruisrgfsdgfiusdgfiuosdghfiudg");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: GetBuilder<HomeController>(
          builder: (c) {
            return Text("Total item is ${homeController.cartList.length}");
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: GetBuilder<HomeController>(
              builder: (controller) {
                return ListView.builder(
                    itemCount: homeController.cartList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              "${homeController.cartList[index].image}",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            Text("${homeController.cartList[index].name}"),
                            Text(
                                "${homeController.cartList[index].price! * homeController.cartList[index].quantity}"),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    homeController.cartList[index].quantity > 0
                                        ?
                                        // ? homeController
                                        //     .cartList[index].quantity--
                                        homeController.decrementQuantity(index)
                                        :
                                        // : homeController.cartList
                                        //     .removeAt(index);
                                        null;
                                    // getTotal();
                                  },
                                  child: Icon(Icons.remove),
                                ),
                                Text(
                                    "${homeController.cartList[index].quantity}"),
                                InkWell(
                                  onTap: () {
                                    homeController.incrementQuantity(index);
                                    // getTotal();
                                  },
                                  child: Icon(Icons.add),
                                ),
                                InkWell(
                                  onTap: () {
                                    homeController.removeFromCart(index);
                                    // getTotal();
                                  },
                                  child: Icon(Icons.delete),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
            )),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.blue,
              child: GetBuilder<HomeController>(builder: (context) {
                return Text(
                  // "Total price is ${}",
                  "Total Price${homeController.netTotal}",

                  //"Total price is  ${netTotal ?? 0}",
                );
              }),
            )
          ],
        ),
      ),
    ));
  }
}
