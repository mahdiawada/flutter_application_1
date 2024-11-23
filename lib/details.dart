import 'package:flutter/material.dart';

class ItemsDetails extends StatefulWidget {
  final data;
  const ItemsDetails({super.key, this.data});

  @override
  State<ItemsDetails> createState() => _ItemsDetailsState();
}

class _ItemsDetailsState extends State<ItemsDetails> {
  String? ItemColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        //centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         const   Icon(Icons.shop_outlined),
            Container(width: 5,),
         const Text("Awada's " , style: TextStyle(fontWeight: FontWeight.w800),),
         const Text("Shop" , style: TextStyle(fontWeight: FontWeight.w800,color: const Color.fromARGB(255, 255, 145, 0)),)
        ],),
        
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
         Container(child: Image.asset(widget.data['image'] , height:350,) , decoration: BoxDecoration(border: Border.all(color: Colors.orange , width: 6) ,borderRadius: BorderRadius.circular(20) ),),
         Container(height: 15,),
         Text(widget.data["title"] , textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w800 , fontSize: 25),),
         Container(height: 7,),
         Text(widget.data["category"], textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 15 , color: Colors.grey[600]),),
        Container(height: 7,),
        Text(widget.data["price"] , textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20 , color: Colors.orange[700]),),
             Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [
          const Text("Color: " , style: TextStyle(fontWeight: FontWeight.w800 , fontSize: 17),) ,
          Expanded(
            child: RadioListTile(
              title: Text("Black"),
              value: "Black",
               groupValue: ItemColor, 
              onChanged: (val){setState(() {
              ItemColor=val;
            });}),
          ) , 
          Expanded(
            child: RadioListTile(
              title: Text("Grey"),
              value: "Grey",
               groupValue: ItemColor, 
              onChanged: (val){setState(() {
              ItemColor=val;
            });}),
          ) ,
        ],) , 
        Container(height: 20,),
       MaterialButton(
        height: 50,
                  color: Colors.black,
                  textColor: Colors.white,
                  child: const Text("Add to Cart" , style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                  onPressed: (){})
        ],
        ),
      ),
    );
  }
}