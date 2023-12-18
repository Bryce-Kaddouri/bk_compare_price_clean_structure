import 'package:bk_compare_price_mvc/src/core/component/text_field_widget.dart';
import 'package:bk_compare_price_mvc/src/features/products/presentation/provider/product_provider.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/provider/supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().getProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(context.watch<ProductProvider>().isLoading){
      return Center(child: CircularProgressIndicator(),);
    }else if(context.watch<ProductProvider>().selectedProduct == null){
      return Scaffold(
        appBar: AppBar(title: Text('Supplier Detail'), centerTitle: true, automaticallyImplyLeading: false, leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Get.toNamed('/suppliers');
        },),),
        body: Center(child: Text('No Supplier'),),
      );
    }

          return Scaffold(
            appBar: AppBar(title: Text(context.watch<ProductProvider>().selectedProduct!.name), centerTitle: true, automaticallyImplyLeading: false, leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
              Get.toNamed('/products');
            },),),
            body:
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
            decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(125),
            ),
            height: 250,
            width: 250,
              child:Stack(
                  children:[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(125),
                  ),
                  height: 250,
                  width: 250,
                  child:ClipOval(
                    child:
                   Image.network(context.watch<ProductProvider>().products.firstWhere((element) => element.id == widget.productId).photoUrl, fit: BoxFit.cover,),
                  ),
                ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(125),
                      ),
                      height: 250,
                      width: 250,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(125),
                          ),
                          height: 50,
                          width: 50,
                          child: IconButton(
                            icon: Icon(Icons.edit, color: Colors.white,),
                            onPressed: (){
                              print('edit');
                            },
                          ),
                        ),
                      ),
                    ),
                ]),
            ),SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(child: TextFieldWidget(label: 'Product Name', controller: context.watch<ProductProvider>().editProductNameController, errorMessage: context.watch<ProductProvider>().editProductNameErrorMessage,isEnable: context.watch<ProductProvider>().isEditingProductName,showSuffixIcon: context.watch<ProductProvider>().editProductNameErrorMessage.isNotEmpty),),
                    if(context.watch<ProductProvider>().isEditingProductName == true)
                      IconButton(onPressed: (){
                        context.read<ProductProvider>().editProductNameController.text = context.read<ProductProvider>().products.firstWhere((element) => element.id == widget.productId).name;
                        context.read<ProductProvider>().toggleIsEditingProductName();
                      }, icon: Icon(Icons.cancel)),
                    IconButton(onPressed: (){
                      if(context.read<ProductProvider>().isEditingProductName == true){
                        print('update');
                        if(context.read<ProductProvider>().editProductNameController.text.isEmpty){
                          context.read<ProductProvider>().setEditProductNameErrorMessage('Please enter supplier name');
                        }else{
                          context.read<ProductProvider>().updateNameProduct(context.read<ProductProvider>().editProductNameController.text);
                          context.read<ProductProvider>().getProductById(widget.productId);
                          context.read<ProductProvider>().toggleIsEditingProductName();
                        }
                      }else {
                        context.read<ProductProvider>().toggleIsEditingProductName();
                      }
                    }, icon: Icon(context.watch<ProductProvider>().isEditingProductName ? Icons.check : Icons.edit))
                  ],
                ),

              ],
            ),
            ),
          );


  }
}