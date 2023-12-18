import 'package:bk_compare_price_mvc/src/features/products/presentation/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget{
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Products"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.pushNamed(context, '/home');
          },
        ),

      ),
      body: Consumer<ProductProvider>(builder: (context, productProvider, child){
        if(productProvider.isLoading){
          return Center(child: CircularProgressIndicator(),);
        }else{
          if(productProvider.products.isEmpty){
            return Center(child: Text('No Suppliers'),);
          }
          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(productProvider.products[index].name),
                subtitle: Text(productProvider.products[index].id),
                onTap: (){
                  print(productProvider.products[index].id);
                  String productId = productProvider.products[index].id;
                  print(productId);
                  Get.toNamed('/products/detail/${productProvider.products[index].id}');
                },
              );
            },
          );
        }

      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/products/add');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      )
    );
  }
}