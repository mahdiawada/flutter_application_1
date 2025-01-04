import 'package:flutter/material.dart';
import 'cart.dart';
import 'products.dart';


class ItemsDetails extends StatefulWidget {
  final Product data;
  const ItemsDetails({super.key, required this.data});

  @override
  State<ItemsDetails> createState() => _ItemsDetailsState();
}

class _ItemsDetailsState extends State<ItemsDetails> {
  String? ItemColor;

  // Function to add product to static cart
  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);  // Correctly access static cartItems
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title:const  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.shop_outlined),
             SizedBox(width: 5),
             Text(
              "Awada's ",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
             Text(
              "Shop",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 255, 145, 0),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              child: Image.asset(
                './images/${widget.data.imagelink}',
                height: 350,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 6),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.data.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
            ),
            const SizedBox(height: 7),
            Text(
              widget.data.category,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.grey[600]),
            ),
            const SizedBox(height: 7),
            Text(
              widget.data.price.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.orange[700]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Color: ",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text("Black"),
                    value: "Black",
                    groupValue: ItemColor,
                    onChanged: (val) {
                      setState(() {
                        ItemColor = val;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text("Grey"),
                    value: "Grey",
                    groupValue: ItemColor,
                    onChanged: (val) {
                      setState(() {
                        ItemColor = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            MaterialButton(
              height: 50,
              color: Colors.black,
              textColor: Colors.white,
              child: const Text(
                "Add to Cart",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              onPressed: () {
                addToCart(widget.data);  // Adding the product to the cart
              },
            ),
          ],
        ),
      ),
    );
  }
}