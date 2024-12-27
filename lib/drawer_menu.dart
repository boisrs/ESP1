import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/ShowListDataPage.dart';

class drawer_menu extends StatefulWidget {
  const drawer_menu({super.key});

  @override
  State<drawer_menu> createState() => _drawer_menuState();
}

class _drawer_menuState extends State<drawer_menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/bg1.jpg'),
              fit: BoxFit.cover)
            ),
            accountName: Text('ຮ້ານ Cafe Neverland'), 
            accountEmail: Text('cafeneverland@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset('images/logo1.png',
                fit: BoxFit.cover,),
                
              ),
            ),
            ),
            Card(
              elevation: 5,
              shadowColor: Colors.red,
              child: ListTile(
                leading: Icon(Icons.category,
                size: 25,
                color: Colors.amber[800],),
                title: Text('ຂໍ້ມູນປະເພດສິນຄ້າ',
                style: TextStyle(fontSize: 22.0,
                color: Colors.blue[700]
                ),
                ),
                onTap: () {
                  Navigator.of(context).pop();

                  MaterialPageRoute route = MaterialPageRoute(builder: (c)=> ShowListDataPage());
                  Navigator.of(context).push(route);
                },
              ),
            ),
            Card(
              elevation: 5,
              shadowColor: Colors.red,
              child: ListTile(
                leading: Icon(Icons.category,
                size: 25,
                color: Colors.amber[800],),
                title: Text('ຫົວຫນ່ວຍ',
                style: TextStyle(fontSize: 22.0,
                color: Colors.blue[700]
                ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Card(
              elevation: 5,
              shadowColor: Colors.red,
              child: ListTile(
                leading: Icon(Icons.folder_copy_rounded ,
                size: 25,
                color: Colors.amber[800],),
                title: Text('ຂໍ້ມູນສິນຄ້າ',
                style: TextStyle(fontSize: 22.0,
                color: Colors.blue[700]
                ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Card(
              elevation: 5,
              shadowColor: Colors.red,
              child: ListTile(
                leading: Icon(Icons.shopping_cart,
                size: 25,
                color: Colors.amber[800],),
                title: Text('ຂາຍ',
                style: TextStyle(fontSize: 22.0,
                color: Colors.blue[700]
                ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Card(
              elevation: 5,
              shadowColor: Colors.red,
              child: ListTile(
                leading: Icon(Icons.arrow_circle_left,
                size: 25,
                color: Colors.amber[800],),
                title: Text('ສັ່ງຊື່ສຶນຄ້າ',
                style: TextStyle(fontSize: 22.0,
                color: Colors.blue[700]
                ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Card(
              elevation: 5,
              shadowColor: Colors.red,
              child: ListTile(
                leading: Icon(Icons.arrow_forward,
                size: 25,
                color: Colors.amber[800],),
                title: Text('ນຳເຂົ້າສິນຄ້າ',
                style: TextStyle(fontSize: 22.0,
                color: Colors.blue[700]
                ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Card(
              elevation: 5,
              shadowColor: Colors.red,
              child: ListTile(
                leading: Icon(Icons.search,
                size: 25,
                color: Colors.amber[800],),
                title: Text('ຄົ້ນຫາ',
                style: TextStyle(fontSize: 22.0,
                color: Colors.blue[700]
                ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Card(
              elevation: 5,
              shadowColor: Colors.red,
              child: ListTile(
                leading: Icon(Icons.bar_chart_sharp,
                size: 25,
                color: Colors.amber[800],),
                title: Text('ລາຍງານ',
                style: TextStyle(fontSize: 22.0,
                color: Colors.blue[700]
                ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            )

        ],
      ),
    );
  }
}