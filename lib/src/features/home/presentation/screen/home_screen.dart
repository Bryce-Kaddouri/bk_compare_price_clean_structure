import 'package:bk_compare_price_mvc/src/features/search/presentation/provider/search_provider.dart';
import 'package:bk_compare_price_mvc/src/features/search/presentation/widget/search_bar_widget.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/provider/supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/provider/auth_provider.dart';
import '../../../bar_chart/presentation/widget/bar_chart_widget.dart';
import '../../../line_chart/presentation/widget/line_chart_widget.dart';
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
      if (context.read<ProductProvider>().selectedProduct != null) {
        context.read<ProductProvider>().getProductById(
            context.read<ProductProvider>().selectedProduct!.id, true);
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
        title: SearchBarWidget(),
      ),
      body: SingleChildScrollView(
          child: context.watch<SearchProvider>().selectedProduct == null
              ? Container()
              : Column(
                  children: [
                    const Text('Current Price by Supplier',
                        style: TextStyle(
                            fontSize: 24,
                            decoration: TextDecoration.underline)),
                    const SizedBox(
                      height: 20,
                    ),
                    BarChartWidget(),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text('Price History by Supplier',
                        style: TextStyle(
                            fontSize: 24,
                            decoration: TextDecoration.underline)),
                    const SizedBox(
                      height: 20,
                    ),
                    LineChartWidget(),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              context.read<SearchProvider>().suppliers.length,
                          itemBuilder: (context, index) {
                            String supplierId =
                                context.read<SearchProvider>().suppliers[index];
                            return Container(
                              color: context
                                  .read<SupplierProvider>()
                                  .suppliers
                                  .firstWhere(
                                      (element) => element.id == supplierId)
                                  .color,
                              child: Text(context
                                  .read<SupplierProvider>()
                                  .suppliers
                                  .firstWhere(
                                      (element) => element.id == supplierId)
                                  .name),
                            );
                          }),
                    ),
                  ],
                )),
    );
  }
}
