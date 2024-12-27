import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
   String proid="";


  var f = NumberFormat("#,##0.00");

  TextEditingController txtsearch = TextEditingController();


  TextEditingController txtproID = TextEditingController();
  TextEditingController txtproname = TextEditingController();
  TextEditingController txtqty = TextEditingController();
  TextEditingController txtimprice = TextEditingController();
  TextEditingController txtsaleprice = TextEditingController();
  TextEditingController txtsupid = TextEditingController();
  TextEditingController txtlevel = TextEditingController();
  TextEditingController txtuid = TextEditingController();
  TextEditingController txtcatid = TextEditingController();

  List data = [];
  final String url =
      "http://172.20.10.4:8000/tbproducts";
  void initState() {
    fetchAllData();
    fetchOne("");
    txtsearch.text = "";
    txtproname.text = "";
    txtqty.text = "";
    txtimprice.text = "";
    txtsaleprice.text = "";
    txtsupid.text = "";
    txtlevel.text = "";
    txtuid.text = "";
    txtcatid.text = "";
    txtproID.text = "";

    fetchtbproducts(); 
    super.initState();
  }

  @override
  void dispose() {
    txtsearch.dispose();
    txtproname.dispose();
    txtqty.dispose();
    txtimprice.dispose();
    txtsaleprice.dispose();
    txtsupid.dispose();
    txtlevel.dispose();
    txtuid.dispose();
    txtcatid.dispose();
    txtproID.dispose();

    super.dispose();
  }
  List datacatch=[];

  Future<void> fetchtbproducts() async{
    try{
      final String urltbproducts="http://172.20.10.4:8000/tbproducts";
      final respond = await http.get(Uri.parse(urltbproducts));

      if(respond.statusCode==200){
        datacatch.clear();
        setState(() {
          
          datacatch = json.decode(respond.body);
        });
      }
    print(datacatch);
    }catch(e){
      print(e);
    }
  }
  Future<void> DeleteData(String proID,) async {
    try {
      final String urldelete = "http://172.20.10.4:8000/tbproducts/$proID";
      final respon = await http.delete(Uri.parse(urldelete));
      if (respon.statusCode == 200) {
        print("ລຶບຂໍ້ມູນແລ້ວ ${respon.body}");
      } else {
        print("ບໍ່ສາມາດລຶບຂໍ້ມູນ ${respon.statusCode}");
      }
      fetchAllData();
    } catch (e) {}
  }

  Future<void> EditcatData(String proID, String proname,String qty, String imprice,String saleprice, String supid, String level,String uid,String catid) async {
    try {
      final String urledit = "http://172.20.10.4:8000/tbproducts/$proID";
      final respon = await http.put(Uri.parse(urledit),
          headers: {"content-type": "application/json"},
          body: json.encode({
          "proID": proID,
          "proname": proname,
          "qty": qty.toString(), // Ensure qty is a string
          "imprice": imprice.toString(), // Ensure imprice is a string
          "saleprice": saleprice.toString(), // Ensure saleprice is a string
          "supid": supid.toString(), // Ensure supid is a string
          "level": level,
          "uid": uid.toString(), // Ensure uid is a string
          "catid": catid.toString() // Ensure catid is a string
        }));

      if (respon.statusCode == 200) {
        print("ແກ້ໄຂຂໍ້ມູນແລ້ວ ${respon.body}");
      } else {
        print("ເກີດຂໍ້ຜິດພາດ ${respon.statusCode}");
      }

      fetchAllData();
      proID="";
    } catch (e) {
      print(e);
    }
  }

  Future<void> AddcatData(
      String proID, String proname, String qty, String imprice,String saleprice, String supid, String level,String uid,String catid) async {
     try {
    final String urledit = "http://172.20.10.4:8000/tbproducts/$proID";
    final respon = await http.put(Uri.parse(urledit),
        headers: {"content-type": "application/json"},
        body: json.encode({
          "proname": proname,
          "qty": qty.toString(), // Ensure qty is a string
          "imprice": imprice.toString(), // Ensure imprice is a string
          "saleprice": saleprice.toString(), // Ensure saleprice is a string
          "supid": supid.toString(), // Ensure supid is a string
          "level": level,
          "uid": uid.toString(), // Ensure uid is a string
          "catid": catid.toString() // Ensure catid is a string
        }));

      setState(() {
        if (respon.statusCode == 200) {
        print("ບັນທຶກຂໍ້ມູນແລ້ວ ${respon.body}");
        proID="";
      } else {
        print("ເກີດຂໍ້ຜິດພາດ ${respon.statusCode}");
      }
      fetchAllData();
      
      });

      
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAllData() async {
    final respons = await http.get(Uri.parse(url));
    if (respons.statusCode == 200) {
      setState(() {
        data = json.decode(respons.body);
      });
    }
    print(data);
  }

  void ClearText() {
    txtproID.text = "";
    txtproname.text = "";
    txtqty.text = "";
    txtimprice.text = "";
    txtsaleprice.text = "";
    txtsupid.text = "";
    txtlevel.text = "";
    txtuid.text = "";
    txtcatid.text = "";
  }

  Future<void> fetchOne(String proID) async {
    final String urlone = "http://172.20.10.4:8000/tbproducts/$proID";
    final respons = await http.get(Uri.parse(urlone));
    if (respons.statusCode == 200) {
      setState(() {
        data = json.decode(respons.body);
      });
    }
    print(data);
  }
  Widget Texttbproducts() {
    return Column(
      children: [
        TextField(
          controller: txtproID,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ລະຫັດສິນຄ້າ'),
              prefixIcon: Icon(
                Icons.book_rounded,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: txtproname,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ລາຍການສິນຄ້າ'),
              prefixIcon: Icon(
                Icons.book,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: txtqty,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ປະລິມານສິນຄ້າ'),
              prefixIcon: Icon(
                Icons.book,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: txtimprice,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ເງິນເຂົ້າ'),
              prefixIcon: Icon(
                Icons.book,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: txtsaleprice,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ລາຄາຂາຍ'),
              prefixIcon: Icon(
                Icons.book,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: txtsupid,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ລະຫັດຜູ້ສະໜອງ'),
              prefixIcon: Icon(
                Icons.book,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: txtlevel,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ເລເວວ'),
              prefixIcon: Icon(
                Icons.book,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: txtuid,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ລະຫັດຫົວໜ່ວຍ'),
              prefixIcon: Icon(
                Icons.book,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),TextField(
          controller: txtcatid,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ລະຫັດປະເພດສິນຄ້າ'),
              prefixIcon: Icon(
                Icons.book,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
   
  
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 110,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 148, 226, 133),
                      elevation: 12,
                      shadowColor: Color.fromARGB(255, 61, 104, 56)),
                  onPressed: () {
                    if(proid !=""){
                      EditcatData(txtproID.text, txtproname.text,txtqty.text,txtimprice.text,txtsaleprice.text,txtlevel.text,txtsupid.text,txtuid.text,txtcatid.text);
                      ClearText();
                      
                    } else
                      AddcatData(txtproID.text, txtproname.text,txtqty.text,txtimprice.text,txtsaleprice.text,txtlevel.text,txtsupid.text,txtuid.text,txtcatid.text);
                      ClearText();
                      Navigator.of(context).pop();  
                  },
                  child: Text(
                    'ບັນທຶກ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 110,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 223, 82, 82),
                      elevation: 15,
                      shadowColor: Color.fromARGB(255, 104, 56, 56)),
                  onPressed: () {},
                  child: Text(
                    'ຍົກເລີກ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ],
    );
  }


  void Addtbproducts() {
  showDialog(
    context: context,
    builder: (c) {
      return AlertDialog(
        backgroundColor: Colors.amber,
        title: Text('ເພິ່ມຂໍ້ມູນ'),
        content: SizedBox(
          // width: MediaQuery.of(context).size.width * 1.0, // 100% ของหน้าจอ
          // height: MediaQuery.of(context).size.height * 0.7, // 70% ของหน้าจอ
          child: SingleChildScrollView( // เพิ่ม Scroll ในกรณีเนื้อหายาว
            child: Texttbproducts(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ຍົກເລີກ'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ຈັດການຂໍ້ມູນສິນຄ້າ"),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              width: MediaQuery.of(context).size.width * 0.87,
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    if (txtsearch.text == "") {
                      fetchAllData();
                    } else {
                      fetchOne(val);
                    }
                  });
                },
                controller: txtsearch,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Search",
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                txtsearch.clear();
                                fetchAllData();
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.red[900],
                              size: 25.0,
                            )),
                        IconButton(
                            onPressed: () {
                              if (txtsearch.text == "") {
                                fetchAllData();
                              } else {
                                fetchOne(txtsearch.text);
                              }
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.blue.shade900,
                              size: 25,
                            ))
                      ],
                    )),
              ),
            )),
      ),
      body: data == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (c, idx) {
                final getdata = data[idx];
                return Column(
                  children: [
                    ListTile(
                      leading: Text(
                        getdata['proID'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        getdata['proname'],
                        style: TextStyle(
                            color: Colors.blue.shade300,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        getdata['qty'].toString(),
                        style: TextStyle(
                            color: Colors.blue.shade300,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                proid ='${getdata['proID'].toString()}';
                                txtproID.text = '${getdata['proID']}';
                                txtproname.text = '${getdata['proname']}';
                                txtqty.text = '${getdata['qty']}';
                                txtimprice.text = '${getdata['imprice']}';
                                txtsaleprice.text = '${getdata['saleprice']}';
                                txtsupid.text = '${getdata['supid']}';
                                txtlevel.text = '${getdata['level']}';
                                txtuid.text = '${getdata['uid']}';
                                txtcatid.text = '${getdata['catid']}';
                        
                                Addtbproducts();
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green.shade900,
                                size: 25,
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (c) {
                                      return AlertDialog(
                                        title: Text("ລຶບຂໍ້ມູນປື້ມ"),
                                        content: Text(
                                            "ທ່ານຕ້ອງການລຶບຂໍ້ມູນນີ້ ຫຼື ບໍ່ [yes/no]"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                DeleteData("${getdata['proID']}");
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Yes')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No')),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade900,
                                size: 25,
                              ))
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade900,
        onPressed: () {
          
          Addtbproducts();
        },
        child: Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}