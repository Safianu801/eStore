import 'package:e_store/features/account/screens/profile_screen.dart';
import 'package:e_store/features/auth/model/user_provider.dart';
import 'package:e_store/features/e_commerce/cart/screens/cart_screen.dart';
import 'package:e_store/features/e_commerce/shop/components/advert_card.dart';
import 'package:e_store/features/e_commerce/shop/components/advert_section.dart';
import 'package:e_store/features/e_commerce/shop/components/categories_section.dart';
import 'package:e_store/features/e_commerce/shop/components/custom_floating_action_button.dart';
import 'package:e_store/features/e_commerce/shop/components/popular_products_section.dart';
import 'package:e_store/features/e_commerce/shop/components/product_section.dart';
import 'package:e_store/features/e_commerce/shop/screens/search_product_screen.dart';
import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../../../notifications/screens/notification_screen.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Future<List<ProductModel>> _futureProducts;
  final ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();
    _futureProducts = productService.getAllProducts(context);
  }

  Future<void> _refreshProducts(BuildContext context) async {
    setState(() {
      _futureProducts = productService.getAllProducts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).userModel;
    return Scaffold(
      backgroundColor: const Color(AppColors.whiteColor),
      appBar: AppBar(
        backgroundColor: const Color(AppColors.whiteColor),
        surfaceTintColor: const Color(AppColors.whiteColor),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
              child: Hero(
                tag: 'name->${user.firstName}--${user.lastName[0]}',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      color: Color(AppColors.primaryColor),
                      shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Text(
                        "${user.firstName[0]}${user.lastName[0]}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hello ${user.firstName} ${user.lastName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13
                  ),
                ),
                const Text(
                  "what are we buying today?",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchProductScreen()));
            },
            child: Container(
              height: 30,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50)
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Icon(IconlyLight.search, color: Colors.grey, size: 15,),
                    SizedBox(width: 5,),
                    Text("Search...", style: TextStyle(color: Colors.grey, fontSize: 12),)
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NotificationScreen()));
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle
              ),
              child: const Center(
                child: Icon(IconlyLight.notification),
              ),
            ),
          ),
          const SizedBox(width: 10,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(AppColors.primaryColor).withOpacity(0.1),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Welcome to eStore, were you can get it all with just few clicks"
                ),
              ),
            ),
            const SizedBox(height: 10,),
            const AdvertSection(),
            const SizedBox(height: 10,),
            const CategoriesSection(),
            const SizedBox(height: 10,),
            PopularProductsSection(futureProducts: _futureProducts,),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 130,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: [Colors.black.withOpacity(0.1), Colors.grey.withOpacity(0.1)])
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(child: SizedBox(
                        child: Image.asset("images/ad_shoe.png"),
                      )),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "25% Discount",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 15
                            ),
                          ),
                          const Text(
                            "Enjoy flash sale and save up to 100% on all nike shoes.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(
                                child: Text(
                                  "Shop now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            ProductSection(title: "Kids", futureProducts: _futureProducts,  categories: const [
              "electronics",
              "jewelery",
              // "men's clothing",
              // "women's clothing",
            ],),
            const SizedBox(height: 5,),
            const AdvertCard(),
            const SizedBox(height: 5,),
            ProductSection(title: "Female", futureProducts: _futureProducts,  categories: const [
              // "electronics",
              // "jewelery",
              "men's clothing",
              // "women's clothing",
            ],),
            const SizedBox(height: 5,),
            ProductSection(title: "Outdoor Decoration", futureProducts: _futureProducts,  categories: const [
              // "electronics",
              // "jewelery",
              // "men's clothing",
              "women's clothing",
            ],)
          ],
        ),
      ),
      floatingActionButton: const CustomFloatingActionButton(),
    );
  }
}
