import 'package:flutter/material.dart';
import 'package:work_1/home_page_controller.dart';
import 'package:work_1/model_cart.dart';
import 'package:work_1/cart_page.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.tealAccent,
          leading: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.to(CartPage());
                    },
                    icon: Icon(
                      Icons.shopping_cart_checkout_outlined,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 20,
                ),
                // Icon(Icons.search, color: Colors.black),
                // SizedBox(
                //   width: 20,
                // ),
                // Icon(Icons.settings, color: Colors.black),
                // SizedBox(
                //   width: 20,
                // ),
              ],
            )
          ],
          title: GetBuilder<HomeController>(
            builder: (controller) {
              return Text(
                "toatl cart item is ${homeController.cartList.length}",
              );
            },
          )),
      body: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.2),
                    shrinkWrap: true,
                    itemCount: myCartLists.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            AspectRatio(
                              child: Image.network(
                                "${myCartLists[index].image}",
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              aspectRatio: 2.5,
                            ),
                            Text("${myCartLists[index].name}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${myCartLists[index].price}"),
                                InkWell(
                                  onTap: () {
                                    try {
                                      homeController.cartList.firstWhere(
                                          (element) =>
                                              element.id ==
                                              myCartLists[index].id);
                                      var snackBar = SnackBar(
                                        content:
                                            Text('Already Added this item'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } catch (e) {
                                      homeController
                                          .addToCart(myCartLists[index]);
                                    }
                                  },
                                  child: Icon(Icons.shopping_basket),
                                )
                              ],
                            ),
                            Text(
                              "${myCartLists[index].productDesc}",
                              style: TextStyle(),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      );
                    })),
            MaterialButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => CartPage()));
                Get.to(CartPage());
              },
              child: Text("Go To Cart"),
              color: Colors.red,
              minWidth: double.infinity,
              height: size.height * 0.1,
            )
          ],
        ),
      ),
    ));
  }
}
