import 'package:e_store/features/e_commerce/shop/screens/product_view_screen.dart';
import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:e_store/utilities/shared_components/custom_Text_field_one.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utilities/constant/app_strings.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _searchResults = [];
  bool _isLoading = false;
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  void _loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = prefs.getStringList('searchHistory') ?? [];
    });
  }

  void _saveSearchHistory(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (!_searchHistory.contains(query)) {
        _searchHistory.add(query);
        prefs.setStringList('searchHistory', _searchHistory);
      }
    });
  }

  void _searchProducts(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      ProductService productService = ProductService();
      _searchResults = await productService.searchProducts(
        context: context,
        name: query,
      );
      _saveSearchHistory(query);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.whiteColor),
      appBar: AppBar(
        backgroundColor: const Color(AppColors.whiteColor),
        surfaceTintColor: const Color(AppColors.whiteColor),
        centerTitle: true,
        title: const Text(
          'Search Products',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: "search",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _searchProducts(_searchController.text.trim());
                        });
                      },
                      icon: const Icon(IconlyLight.search)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.0),
                      borderRadius: BorderRadius.circular(50)),
                  fillColor: Colors.grey.withOpacity(0.2),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 1)),
            ),
            if (_isLoading) const CupertinoActivityIndicator(),
            Expanded(
              child: _searchResults.isEmpty
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: _searchHistory.isNotEmpty ? MainAxisAlignment.start : MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16.0),
                          _searchHistory.isNotEmpty
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Search History",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Wrap(
                                      spacing: 8.0,
                                      children: _searchHistory
                                          .map((query) => Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 2.0),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      _searchController.text = query;
                                                      _searchProducts(query);
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        query,
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          setState(() {
                                                            _searchHistory.remove(query);
                                                            SharedPreferences.getInstance()
                                                                .then((prefs) {
                                                              prefs.setStringList(
                                                                  'searchHistory',
                                                                  _searchHistory);
                                                            });
                                                          });
                                                        },
                                                        child: Container(
                                                            height: 15,
                                                            width: 15,
                                                            decoration: BoxDecoration(
                                                                color: Colors.grey[200],
                                                                shape: BoxShape.circle),
                                                            child: const Icon(
                                                              Icons.close,
                                                              color: Colors.grey,
                                                              size: 10,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                ],
                              )
                              : const Center(child: Column(
                                children: [
                                  Icon(Icons.hourglass_empty, color: Colors.grey,),
                                  Text("No searches yet", style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                  ),),
                                  Text(
                                    "Looks like either you've cleared your search history or you have not made any search yet, brows through our collections of product with ease.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final product = _searchResults[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductViewScreen(
                                      productModel: product)));
                            },
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(product.image),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title.length > 30
                                            ? "${product.title.substring(0, 30)}..."
                                            : product.title,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        product.category,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                      Text(
                                        "${AppStrings.nairaSign}${_formatPrice(product.price)}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: const Color(
                                                  AppColors.primaryColor)
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    try {
      return _formatNumber(price);
    } catch (e) {
      return '0';
    }
  }

  String _formatNumber(double number) {
    NumberFormat formatter = NumberFormat("#,###");
    return formatter.format(number);
  }
}
