class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  void printError(){
    print('CustomException: $message');
  }

  @override
  String toString() {
    return message;
  }

  void showErrorMessage(){
    print('CustomException: $message');
  }


}
