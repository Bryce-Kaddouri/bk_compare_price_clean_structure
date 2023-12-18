import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product"), centerTitle: true, automaticallyImplyLeading: false, leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
        Navigator.pushNamed(context, '/products');
      },),),
      body: Center(child: Text('Add Product'),),
    );
  }
}