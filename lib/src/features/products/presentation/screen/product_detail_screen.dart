import 'package:bk_compare_price_mvc/src/core/component/text_field_widget.dart';
import 'package:bk_compare_price_mvc/src/features/products/presentation/provider/product_provider.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/provider/supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../suppliers/data/model/supplier_model.dart';

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
      context.read<SupplierProvider>().getAllSuppliers();

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
            body:SingleChildScrollView(
              child:
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
                SizedBox(height: 20,),
                Text('Prices', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                if(context.watch<ProductProvider>().isAddingPrice)
                Container(
                  child:Column(
                    children: [
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          hintText: 'Enter Date',
                          errorText: context.watch<ProductProvider>().addPriceErrorMessage,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          errorStyle: TextStyle(color: Colors.black),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusColor: Colors.black,

                        ),
                        controller: context.watch<ProductProvider>().addPriceDateTimeController,
                        onTap: (){
                          context.read<ProductProvider>().selectDate(context);
                        },

                      ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:DropdownButton<String>(
                          isExpanded: true,
                          underline: SizedBox(),
                          itemHeight: 50,
                          value: context.watch<SupplierProvider>().suppliers.elementAt(context.watch<ProductProvider>().addIndexSupplier).id,
                          onChanged: (String? newValue) {
                            print(newValue);
                            context.read<ProductProvider>().setAddIndexSupplier(context.read<SupplierProvider>().suppliers.indexWhere((element) => element.id == newValue));
                            context.read<ProductProvider>().setAddSupplierId(newValue!);
                            /*context.read<ProductProvider>().setSelectedSupplierId(newValue!);*/
                          },
                          borderRadius: BorderRadius.circular(10),
                          items: context.watch<SupplierProvider>().suppliers.map<DropdownMenuItem<String>>((SupplierModel value) {
                            return DropdownMenuItem<String>(
                              value: value.id,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Price',
                          hintText: '10.50',

                          errorText: context.watch<ProductProvider>().addPriceErrorMessage,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          errorStyle: TextStyle(color: Colors.black),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusColor: Colors.black,

                        ),
                        controller: context.watch<ProductProvider>().addPriceController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          // priceFormatter,
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),

                        ],
                      ),
                    ],
                  ),
                ),
                if(!context.watch<ProductProvider>().isAddingPrice)
                  ElevatedButton(onPressed: (){
                    context.read<ProductProvider>().setIsAddingPrice(true);
                  }, child: Text('Add Price'))
                else
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){
                        context.read<ProductProvider>().setIsAddingPrice(false);
                      }, child: Text('Cancel')),
                      SizedBox(width: 20,),
                      ElevatedButton(onPressed: (){
                        if(context.read<ProductProvider>().addPriceController.text.isEmpty){
                          context.read<ProductProvider>().setAddPriceErrorMessage('Please enter price');
                        }else if(context.read<ProductProvider>().addPriceDateTimeController.text.isEmpty){
                          context.read<ProductProvider>().setAddPriceErrorMessage('Please enter date');
                        }else{
                          context.read<ProductProvider>().addProductPrice();
                          context.read<ProductProvider>().setIsAddingPrice(false);
                          context.read<ProductProvider>().getProductById(widget.productId);
                        }
                      }, child: Text('Add')),
                    ],
                  ),

                SizedBox(height: 20,),
                if(context.watch<ProductProvider>().selectedProduct!.prices.isEmpty)
                  Text('No Price')
                else
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: context.watch<ProductProvider>().allSuppliers.length,
                      itemBuilder: (context, index){
                        print(context.watch<ProductProvider>().selectedProduct!.prices.first.supplierId);
                        return Column(
                          children: [
                            Text(context.watch<SupplierProvider>().suppliers.where((element) => element.id == context.watch<ProductProvider>().allSuppliers.elementAt(index)).first.name),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: context.watch<ProductProvider>().selectedProduct!.prices.where((element) => element.supplierId == context.watch<ProductProvider>().allSuppliers.elementAt(index)).length,
                              itemBuilder: (context, index2){
                                return ListTile(
                                  title: Text(context.watch<ProductProvider>().selectedProduct!.prices.where((element) => element.supplierId == context.watch<ProductProvider>().allSuppliers.elementAt(index)).elementAt(index2).price.toString()),
                                  subtitle: Text(context.watch<ProductProvider>().selectedProduct!.prices.where((element) => element.supplierId == context.watch<ProductProvider>().allSuppliers.elementAt(index)).elementAt(index2).createdAt.toString()),
                                  trailing: IconButton(onPressed: (){
/*
                                    context.read<ProductProvider>().deleteProductPrice(context.watch<ProductProvider>().selectedProduct!.prices.where((element) => element.supplierId == context.watch<ProductProvider>().allSuppliers.elementAt(index)).elementAt(index2).id);
*/
                                  }, icon: Icon(Icons.delete)),
                                );
                              },
                            ),

                          ],
                        );
                      },
                    ),
                  )




              ],
            ),
            ),
            ),
          );


  }
}