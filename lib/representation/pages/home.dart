// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_application_1/BLOC/Auth_Bloc/auth_bloc.dart';
import 'package:flutter_application_1/ColorScheme/app_theme.dart';
import 'package:flutter_application_1/BLOC/home_bloc/home_bloc.dart';
import 'package:flutter_application_1/data/productModel.dart';
import 'package:flutter_application_1/representation/Authentication/Login.dart';
import 'package:flutter_application_1/representation/pages/DetailPage.dart';
import 'package:flutter_application_1/representation/pages/cart.dart';
import 'package:flutter_application_1/utility/SearchBarUi.dart';
import 'package:flutter_application_1/utility/carouselImage.dart';
import 'package:flutter_application_1/utility/product_tile_ui.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  final HomeBloc homebloc = HomeBloc();
  List<Product> _allproducts = [];
  List<Product> _filteredProducts = [];
  @override
  void initState() {
    homebloc.add(HomeInitialEvent());
    super.initState();
  }

  void _search(String query) {
    final results =
        query.isEmpty
            ? _allproducts
            : _allproducts.where((product) {
              return product.title.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  product.description.toLowerCase().contains(
                    query.toLowerCase(),
                  );
            }).toList();
    setState(() {
      _filteredProducts = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginPage()),
            (route) => false,
          );
        }
      },
      child: BlocConsumer<HomeBloc, HomeState>(
        bloc: homebloc,
        listenWhen:
            (previous, current) =>
                current
                    is HomeActionState, // Ensures only action states trigger listener
        buildWhen: (previous, current) => current is! HomeActionState,

        listener: (context, state) {
          if (state is NavigateToDescriptionPageActionState) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 400),
                pageBuilder:
                    (_, animation, __) => FadeTransition(
                      opacity: animation,
                      child: DetailPage(product: state.product),
                    ),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return Scaffold(
                body: Center(
                  child: Lottie.asset(
                    "assets/animations/Loading Animation.json",
                    width: 300,
                    height: 300,
                    fit: BoxFit.fill,
                  ),
                ),
              );

            case HomeLoadingSuccessState:
              final successState = state as HomeLoadingSuccessState;
              final pd = successState.product_list;
              if (_allproducts.isEmpty) {
                _allproducts = pd;
                _filteredProducts = pd; // Initialize filtered products
              }
              return Scaffold(
                backgroundColor: blinkitTheme.scaffoldBackgroundColor,
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: blinkitTheme.canvasColor,
                  title: Row(
                    children: [
                      Image.asset(
                        "assets/animations/logo.png",
                        height: 140, // control size
                      ),
                    ],
                  ),

                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(logoutEvent());
                      },
                      icon: Icon(Icons.logout_outlined, size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (context) => Cart()));
                      },
                      icon: Icon(Icons.shopping_cart, size: 30),
                    ),
                  ],
                ),
                body: SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 10),
                                SearchBarUi(
                                  hint: "Search Your Things......",
                                  onChanged: _search,
                                  TextEditingController: _searchController,
                                ),
                                SizedBox(height: 10),
                                CarouselimageUI(
                                  productList: pd,
                                  homebloc: homebloc,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Categories",
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    shrinkWrap: true,

                                    scrollDirection: Axis.horizontal,
                                    itemCount: pd.length,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return InkWell(
                                        onTap: () {
                                          homebloc.add(
                                            NavigateToDetailPageEvent(
                                              pd[index],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            // ignore: deprecated_member_use
                                            color: Colors.purple.shade100,

                                            shape: BoxShape.circle,
                                          ),
                                          child: Image(
                                            image: NetworkImage(
                                              pd[index].thumbnail,
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 10, left: 8),
                              child: Text(
                                "All Products",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 240,
                                    childAspectRatio:
                                        0.5, // Adjust height of tiles

                                    mainAxisSpacing: 1,
                                  ),
                              itemCount: pd.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductTileUi(
                                  product: pd[index],
                                  homebloc: homebloc,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      if (_filteredProducts.isNotEmpty &&
                          _searchController.text.isNotEmpty)
                        Positioned(
                          top: 70,
                          left: 20,
                          right: 20,
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              constraints: BoxConstraints(maxHeight: 300),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _filteredProducts.length,
                                itemBuilder: (context, index) {
                                  final product = _filteredProducts[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        product.thumbnail,
                                      ),
                                    ),
                                    title: Text(product.title),
                                    subtitle: Text("₹${product.price}"),
                                    onTap: () {
                                      homebloc.add(
                                        NavigateToDetailPageEvent(product),
                                      );
                                      setState(() {
                                        _searchController.clear();
                                        _filteredProducts = [];
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );

            case HomeErrorState:
              return Scaffold(body: Text("error"));
            default:
              return const Scaffold(body: Center(child: Text("No data")));
          }
        },
      ),
    );
  }
}
