import 'package:bk_compare_price_mvc/src/features/search/presentation/widget/search_bar_widget.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/provider/supplier_provider.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/screen/suppliers_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/provider/auth_provider.dart';
import '../../../products/presentation/provider/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthenticationProvider>().getCurrentUser();
      context.read<SupplierProvider>().getAllSuppliers();
      context.read<ProductProvider>().getAllProducts();
      if( context.read<ProductProvider>().selectedProduct != null){
        context.read<ProductProvider>().getProductById(context.read<ProductProvider>().selectedProduct!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Suppliers'),
              onTap: () {
                Get.toNamed('/suppliers');
              },
            ),
            ListTile(
              title: const Text('Products'),
              onTap: () {
                Get.toNamed('/products');
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                context.read<AuthenticationProvider>().signout();
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text('Home Screen'),
      ),

      body:  Column(
          children: <Widget>[
            SearchBarWidget(),
            Text(
              'HomeScreen',
            ),
          ],
      ),
    );
  }
}
