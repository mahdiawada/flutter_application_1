import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

String _baseURL = '127.0.0.1';
// String _baseURL = 'flutterapp321.infy.uk';

class Product {
  int _pid;
  String _name;
  double _price;
  String _imagelink;
  String _category;

  Product(this._pid, this._name,this._price, this._imagelink , this._category);

  int get pid => _pid;
  String get name => _name;
  double get price => _price;
  String get imagelink => _imagelink;
  String get category => _category;  

  @override
  String toString() {
    return """
      Name: $_name 
      Price: \$$_price 
      Category: $_category """;
  }
}

List<Product> products = [];



void getProducts(Function(bool success) update) async {
  try {
    //final url = Uri.parse('http://flutterapp321.infy.uk/get_products.php');
    final url = Uri.http(_baseURL, 'flutter_app/get_products.php');
    final response = await http.get(url).timeout(const Duration(seconds: 20)); 
    products.clear(); 
    if (response.statusCode == 200) { 
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) { 
        Product p = Product(
            int.parse(row['pid']),
            row['name'],
            double.parse(row['price']),
            row['imagelink'],
            row['category']);
        products.add(p); 
      }
      update(true); 
    }
  }
  catch(e) {
    print('Error loading data with error ${e.toString()}');
    update(false); 
  }
}



void getProductByName(Function(List<Product> products) update, String name) async {
  try {
    final url = Uri.http(_baseURL, 'flutter_app/search_products.php', {'name': name});
    final response = await http.get(url).timeout(const Duration(seconds: 15)); 
    if (response.statusCode == 200) { 
      final jsonResponse = convert.jsonDecode(response.body); 
      if (jsonResponse.isEmpty) {
        update([]); 
      } else {
        List<Product> foundProducts = [];
        for (var row in jsonResponse) { 
          Product p = Product(
            int.parse(row['pid']),
            row['name'],
            double.parse(row['price']),
            row['imagelink'],
            row['category'],
          );
          foundProducts.add(p);
        }
        update(foundProducts);
      }
    } else {
      update([]); 
    }
  } catch (e) {
    print('Error loading data with error ${e.toString()}');
    update([]); 
  }
}

