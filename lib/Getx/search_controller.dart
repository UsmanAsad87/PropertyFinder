import 'package:get/get.dart';

class SearchController extends GetxController{
  var searchText=''.obs;
  setString(var text){
    searchText=text;
  }
}