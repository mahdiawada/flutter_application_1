import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart.dart';
import 'package:flutter_application_1/details.dart';
import 'package:flutter_application_1/search.dart';
import 'products.dart';
class Homepage extends StatefulWidget{
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {

  List categories = [
    {"iconname": Icons.laptop , "title" : "Laptop"} ,
    {"iconname": Icons.mobile_friendly , "title" : "Mobile"} ,
    {"iconname": Icons.electric_bike , "title" : "Electronics"} ,
    {"iconname": Icons.headphones , "title" : "Accesories"} ,
  ];

    bool _loaded = false; 

  void update(bool success) {
    setState(() {
      _loaded = true; 
      if (!success) { 
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load data')));
      }
    });
  }

  @override
  void initState() {
    getProducts(update);
    super.initState();
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(children: [
              Expanded(child: MaterialButton(
                textColor: Colors.white,
                padding: const EdgeInsets.all(15),
                color: Colors.orange,
                child: const Text("Click To Search For Products" ,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Search()));
                },
              )) ,
            const  Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(Icons.menu , size: 40,),
              )
            ],
            ),
            Container(height: 30,),
            const Text("Categories" ,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20),),
            Container(height: 10,),
            Container(
              height: 120,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i){
                return  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(100)
                          ),
                          width: 60,
                          height: 60,
                          child: Icon(categories[i]["iconname"] , size: 35,),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 5),),
                          Text(categories[i]["title"] , style: const TextStyle(fontWeight:FontWeight.w600),)
                      
                      ],
                    
                    ),
                  );
                }
                
              ),
              
            ),
           const Text("Best Selling" ,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20),),
             Container(height: 10,),  
              _loaded ? const ShowProducts() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator()))
          ],
          
        ),
      ),
    );
  }
}


class ShowProducts extends StatelessWidget {
  const ShowProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: 
           const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2 ,
                crossAxisSpacing: 10, 
                mainAxisSpacing: 10, 
                mainAxisExtent: 300 
                ),
              itemCount: products.length,
             itemBuilder: (context , i){
                    return  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemsDetails(data:products[i])));
                      },
                      child: Card(
                                      elevation: 10,
                                      child: Column(children: [
                                        Container(
                      padding: const EdgeInsets.all(20),
                      width: 300,
                      child: Image.asset('./images/${products[i].imagelink}',height: 130,fit: BoxFit.fill, errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported,
                        size: 130,
                      );
                    },),
                      
                      ) , 
                          Text(products[i].name ,style: const TextStyle(fontWeight: FontWeight.w800),),
                          Text(products[i].category, style: TextStyle(fontWeight: FontWeight.w400 , color: Colors.grey[600]),),
                          Text("Price: \$${products[i].price.toStringAsFixed(2)}" , style: TextStyle(fontWeight: FontWeight.w400 , color: Colors.grey[600]),),
                          Container(height: 10,),
                      MaterialButton(
                            color: Colors.orange,
                            textColor: Colors.white,
                            child: const Text("Purchase",style: TextStyle(fontWeight: FontWeight.w600),),
                            onPressed: () {
                            Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ItemsDetails(data:products[i]), ),
                              );
                                },
                                  )
                                      ]),
                                     ),
                    ) ;
                }
              );
  }
}
