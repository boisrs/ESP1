import 'package:flutter/material.dart';
import 'package:myapp/ManageHomePage/UnitPage.dart';
import 'package:myapp/ManageHomePage/categoryPage.dart';
import 'package:myapp/ManageHomePage/CurrentExchangePage.dart';
import 'package:myapp/ManageHomePage/CustomerPage.dart';
import 'package:myapp/ManageHomePage/EmployeePage.dart';
import 'package:myapp/ManageHomePage/ProductsPage.dart';
import 'package:myapp/ManageHomePage/SupplierPage.dart';




List itembase = ["ຫົວໜ່ວຍ", "ປະເພດສິນຄ້າ", "ຂໍ້ມູນສິນຄ້າ", "ຂໍ້ມູນຜູ້ສະໜອງ",
                 "ພະນັກງານ", "ຂໍ້ມູນລູກຄ້າ", "ອັດຕາແລກປ່ຽນ"];
List iconColor=[Colors.blue.shade700];
List iconSize=[80.0];
List icon=[Icon(Icons.ac_unit, color:Colors.amber,size: iconSize[0],),
           Icon(Icons.category, color:iconColor[0],size: iconSize[0],),
           Icon(Icons.folder_open, color:Colors.red,size: iconSize[0],),
           Icon(Icons.local_shipping, color:iconColor[0],size: iconSize[0],),
           Icon(Icons.person, color:iconColor[0],size: iconSize[0],),
           Icon(Icons.person_add, color:iconColor[0],size: iconSize[0],),
           Icon(Icons.currency_exchange, color:iconColor[0],size: iconSize[0],),

];

List routPage=[
  const UnitPage(),
  const categoryPage(),
  const ProductsPage(),
  const SupplierPage(),
  const EmployeePage(),
  const CustomerPage(),
  const CurrentExchangePage(),
];
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void selectPage(int idx){
    setState(() {
      MaterialPageRoute route = MaterialPageRoute(builder: (_)=>routPage[idx]);
      Navigator.of(context).push(route);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),//ຂອບດ້ານນອກ
        child: GridView.builder(
          itemCount: itembase.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            ),
             itemBuilder: (c,idx){
              
              return InkWell(
                onTap: ()=>selectPage(idx),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 130,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,width: 2),
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    icon[idx],
                    Spacer(),
                    Text('${itembase[idx]}',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  
                  ]),
                ),
              );
             }),
      ),
    );
  }
}