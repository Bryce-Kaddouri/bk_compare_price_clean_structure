import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Products"), centerTitle: true, automaticallyImplyLeading: false, leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
        Navigator.pushNamed(context, '/home');
      },),),
      body: Center(child: Text('Products'),),
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