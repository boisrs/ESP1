import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/HomePage.dart';
import 'package:myapp/Login/LoginPage.dart';
import 'package:myapp/MessagePage.dart';
import 'package:myapp/ServicePage.dart';
import 'package:myapp/SettingPage.dart';
import 'package:myapp/drawer_menu.dart';

List items=["ຈັດການຂໍ້ມູນພື້ນຖານ","ຂາຍ","ສັ່ງຊື້","ນຳເຂົ້າ","ຄົ້ນຫາ","ລາຍງານ"];
List icon=[Icon(Icons.folder,size: 25,color:Colors.blue,),
          Icon(Icons.shopping_basket,size: 25,),
          Icon(Icons.arrow_back,size: 25,),
          Icon(Icons.arrow_forward,size: 25,),
          Icon(Icons.search,size: 25,),
          Icon(Icons.bar_chart_sharp,size: 25,),
];

const List screenPage=[
  LoginPage(),
  MessagePage(),
  SettingPage(),
  ServicePage()

];

class myHomePage extends StatefulWidget {
  const myHomePage({super.key});

  @override
  State<myHomePage> createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  int selectidx = 1;

  void onTabTapped(int idx){
    setState(() {
      selectidx = idx;
    });

  }
  Widget PopUpMenuitemBar(){
    return PopupMenuButton <String>(itemBuilder: (c)=>[
      PopupMenuDivider(),
      PopupMenuItem(child: ListTile(
        leading:Icon(Icons.settings,
        color: Colors.amber.shade900,),
        title: Text("ຕັ້ງຄ່າ",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 20
        ),
        ),
        onTap: (){
          Navigator.of(context).pop();
        },
      )),
      PopupMenuDivider(),
      PopupMenuItem(child: ListTile(
        leading:Icon(Icons.storage,
        color: Colors.amber.shade900,),
        title: Text("ເຊື່ອມຕໍ່ກັບຖານຂໍ້ມູນ",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 20
        ),
        ),
        onTap: (){
          Navigator.of(context).pop();
        },
      )),
      PopupMenuDivider(),
      PopupMenuItem(child: ListTile(
        leading:Icon(Icons.wifi,
        color: Colors.amber.shade900,),
        title: Text("ເຊື່ອມຕໍ່ກັບ Internet",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 20
        ),
        ),
        onTap: (){
          Navigator.of(context).pop();
        },
      ))
    ]);
  }

  Widget BNavagateBar(){
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold
      ),
      type: BottomNavigationBarType.fixed,
      iconSize: 20,
      backgroundColor: Colors.amber[800],
      currentIndex: selectidx,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.card_membership, color: Colors.white,),
          label: 'ເຂົ້າສູ້ລະບົບ',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.message, color: Colors.white,),
          label: 'ຂໍ້ຄວາມ'
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: Colors.white,),
          label: 'ຕັ້ງຄ່າ'
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.more_vert, color: Colors.white,),
          label: 'ບໍລິການ'
          ),

      ]);
  }

  Widget TabBarMenu(){
    return TabBar(
      isScrollable: true,
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: 17
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 13
      ),

      tabs: [
      Tab(
        icon: icon[0],
        text: items[0],
      ),
      Tab(
        icon: icon[1],
        text: items[1],
      ),
      Tab(
        icon: icon[2],
        text: items[2],
      ),
      Tab(
        icon: icon[3],
        text: items[3],
      ),
      Tab(
        icon: icon[4],
        text: items[4],
      ),
      Tab(
        icon: icon[5],
        text: items[5],
      ),
      
      
    ],);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: items.length,
      child: Scaffold(
        appBar: AppBar(
      
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: TabBarMenu(),
          ),
      
          title: Text('ຮ້ານ Cafe Neverland'),
          actions: [PopUpMenuitemBar(),],
        ),
        
      
        body: TabBarView(children: [Center(
          child: HomePage(),
        ),
        Center(
          child: Text("ຂາຍ"),
        ),
        Center(
          child: Text("ສັ່ງຊື້"),
        ),
        Center(
          child: Text("ນຳເຂົ້າ"),
        ),
        Center(
          child: Text("ຄົ້ນຫາ"),
        ),
        Center(
          child: Text("ລາຍງານ"),
        ),
        ],),
        drawer: drawer_menu(),
      
        bottomNavigationBar: BNavagateBar(),
      ),
    );
  }
}