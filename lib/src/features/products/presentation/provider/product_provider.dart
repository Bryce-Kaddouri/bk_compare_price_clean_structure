import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setIsLoading(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }

  bool _isEditingName = false;
  bool get isEditingName => _isEditingName;
  void setIsEditingName(bool isEditingName){
    _isEditingName = isEditingName;
    notifyListeners();
  }



}

class