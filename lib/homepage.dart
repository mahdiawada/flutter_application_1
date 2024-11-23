import 'package:flutter/material.dart';
import 'package:flutter_application_1/details.dart';

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
    {"iconname": Icons.car_rental , "title" : "Cars"} ,
    {"iconname": Icons.motorcycle , "title" : "Motorcycles"} ,
    
  ];

  List items = [
    {"image":"./images/mobile1.jpg","title":"Iphone 15","category":"Mobiles Category","price":"Price: 500\$"},
    {"image":"./images/headphones1.jpg","title":"Headphones Razor","category":"Accesories","price":"Price: 100\$"},
    {"image":"./images/electronics1.jpg","title":"Usb","category":"Electronics","price":"Price: 50\$"},
    {"image":"./images/mobile2.jpg","title":"S24 Ultra","category":"Mobile Category","price":"Price: 600\$"},
    {"image":"./images/laptop1.jpg","title":"MacBook","category":"Laptops Category","price":"Price: 900\$"},
    {"image":"./images/electronics2.jpg","title":"Ardiuno","category":"Electronics","price":"Price: 30\$"},
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        iconSize: 25,
        selectedItemColor: Colors.orange,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "*") ,
        BottomNavigationBarItem(icon: Icon(Icons.shopping_basket),label: "*") ,
        BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label: "*") ,
      ]),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(children: [
              Expanded(child: TextFormField(
                
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search , color: Colors.black,),
                  hintText: "Search",
                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(10) , borderSide: BorderSide.none),
                  fillColor: Colors.grey[300],
                  filled: true
                ),
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
             GridView.builder(
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: 
           const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2 ,
                crossAxisSpacing: 10, 
                mainAxisSpacing: 10, 
                mainAxisExtent: 300 
                ),
              itemCount: items.length,
             itemBuilder: (context , i){
                    return  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemsDetails(data:items[i])));
                      },
                      child: Card(
                                      elevation: 10,
                                      child: Column(children: [
                                        Container(
                      padding: const EdgeInsets.all(20),
                      width: 300,
                      child: Image.asset(items[i]['image'],height: 130,fit: BoxFit.fill,),
                      ) , 
                                         Text(items[i]['title'] ,style: TextStyle(fontWeight: FontWeight.w800),),
                                         Text(items[i]['category'] , style: TextStyle(fontWeight: FontWeight.w400 , color: Colors.grey[600]),),
                                         Text(items[i]['price'] , style: TextStyle(fontWeight: FontWeight.w400 , color: Colors.grey[600]),),
                                         Container(height: 10,),
                                         MaterialButton(
                      color: Colors.orange,
                      textColor: Colors.white,
                      child: const Text("Purchase" , style: TextStyle(fontWeight: FontWeight.w600),),
                      onPressed: (){})
                      
                                      ]),
                                     ),
                    ) ;
                }
              ),
          ],
          
        ),
      ),
    );
  }
}
