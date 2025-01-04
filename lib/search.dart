import 'package:flutter/material.dart';
import 'package:flutter_application_1/details.dart';
import 'products.dart'; 

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _controllerName = TextEditingController();
  List<Product> _foundedproducts = [];
  bool _searching = false;

   void update(List<Product> products) {
    setState(() {
      _searching = false;
      _foundedproducts = products;
    });
  }

  void searchProductByName() {
    String name = _controllerName.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a product name')));
      return;
    }

    getProductByName(update, name);
    setState(() {
      _searching = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Product by Name'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children:[ Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _controllerName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Product Name',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: searchProductByName,
                child: const Text('Search', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              Center(
                child: _searching
                    ? const CircularProgressIndicator()
                    :  GridView.builder(
                                    physics:const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: 
                                 const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2 ,
                                      crossAxisSpacing: 10, 
                                      mainAxisSpacing: 10, 
                                      mainAxisExtent: 300 
                                      ),
                                    itemCount: _foundedproducts.length,
                                   itemBuilder: (context , i){
                        return  InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemsDetails(data:_foundedproducts[i])));
                          },
                          child: Card(
                                          elevation: 10,
                                          child: Column(children: [
                                            Container(
                          padding: const EdgeInsets.all(20),
                          width: 300,
                          child: Image.asset('./images/${_foundedproducts[i].imagelink}',height: 130,fit: BoxFit.fill, errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 130,
                          );
                        },),
                          
                          ) , 
                              Text(_foundedproducts[i].name ,style: const TextStyle(fontWeight: FontWeight.w800),),
                              Text(_foundedproducts[i].category, style: TextStyle(fontWeight: FontWeight.w400 , color: Colors.grey[600]),),
                              Text("Price: \$${_foundedproducts[i].price.toStringAsFixed(2)}" , style: TextStyle(fontWeight: FontWeight.w400 , color: Colors.grey[600]),),
                              Container(height: 10,),
                          MaterialButton(
                                color: Colors.orange,
                                textColor: Colors.white,
                                child: const Text("Purchase",style: TextStyle(fontWeight: FontWeight.w600),),
                                onPressed: () {
                                Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ItemsDetails(data:_foundedproducts[i]), ),
                                  );
                                    },
                                      )
                                          ]),
                                         ),
                                            );
                                      }
                                    ),
              ),
            ],
          ),
        ),
        ]
      ),
    );
  }
}
