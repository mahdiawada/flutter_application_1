import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:flutter_application_1/products.dart';

List<Product> cartItems = [];

class Cart extends StatefulWidget {

  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  


  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Cart Page" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
    color: Colors.grey[300],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.home_outlined, size: 25),
          onPressed: () {
             Navigator.push(context,MaterialPageRoute(builder: (context) => Homepage()));
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_basket, size: 25),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Cart()),);
          },
        ),
        IconButton(
          icon: const Icon(Icons.person_2_outlined, size: 25),onPressed: () {})
          ],),
  ),
   body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset('./images/${cartItems[index].imagelink}', width: 50, height: 50),
                    title: Text(cartItems[index].name),
                    subtitle: Text('Price: \$${cartItems[index].price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => removeFromCart(index),
                    ),),);},)
    );
  }
}

