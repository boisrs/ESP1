import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  String supid="";


  var f = NumberFormat("#,##0.00");

  TextEditingController txtsearch = TextEditingController();


  TextEditingController txtsupid = TextEditingController();
  TextEditingController txtsupname = TextEditingController();
  TextEditingController txttel = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtcontract = TextEditingController();
  TextEditingController txttelcontract = TextEditingController();

  List data = [];
  final String url =
      "http://192.168.67.207:8000/tbsupplier";
  void initState() {
    fetchAllData();
    fetchOne("");
    txtsearch.text = "";
    txtsupid.text = "";
    txtsupname.text = "";
    txttel.text = "";
    txtemail.text = "";
    txtcontract.text = "";
    txttelcontract.text = "";
    fetchCategory(); 
    super.initState();
  }

  @override
  void dispose() {
    
    txtsearch.dispose();
    txtsupid.dispose();
    txtsupname.dispose();
    txttel.dispose();
    txtemail.dispose();
    txtcontract.dispose();
    txttelcontract.dispose();

    super.dispose();
  }
  List datacatch=[];

  Future<void> fetchCategory() async{
    try{
      final String urlcatrgory="http://192.168.67.207:8000/tbsupplier";
      final respond = await http.get(Uri.parse(urlcatrgory));

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
  Future<void> DeleteData(String supid) async {
    try {
      final String urldelete = "http://192.168.67.207:8000/tbsupplier/$supid";
      final respon = await http.delete(Uri.parse(urldelete));
      if (respon.statusCode == 200) {
        print("ລຶບຂໍ້ມູນແລ້ວ ${respon.body}");
      } else {
        print("ບໍ່ສາມາດລຶບຂໍ້ມູນ ${respon.statusCode}");
      }
      fetchAllData();
    } catch (e) {}
  }

  Future<void> EditcatData(String supid, String supname) async {
    try {
      final String urledit = "http://192.168.67.207:8000/tbsupplier/$supid";
      final respon = await http.put(Uri.parse(urledit),
          headers: {"content-type": "application/json"},
          body: json.encode({
            
            "supname": supname,
          }));

      if (respon.statusCode == 200) {
        print("ແກ້ໄຂຂໍ້ມູນແລ້ວ ${respon.body}");
      } else {
        print("ເກີດຂໍ້ຜິດພາດ ${respon.statusCode}");
      }

      fetchAllData();
      supid="";
    } catch (e) {
      print(e);
    }
  }

 Future<void> AddcatData(String supid, String supname, String tel, String email, String contract, String telcontract) async {
  try {
    final String urladd = "http://192.168.67.207:8000/tbsupplier";
    final respon = await http.post(
      Uri.parse(urladd),
      headers: {"content-type": "application/json"},
      body: json.encode({
        "supid": supid.toString(),
        "supname": supname,
        "tel": tel.toString(),
        "email": email,
        "contract": contract,
        "telcontract": telcontract.toString(),  
      }),
    );
    setState(() {
      if (respon.statusCode == 200) {
        print("ບັນທຶກຂໍ້ມູນແລ້ວ ${respon.body}");
        supid = "";
      } else if (respon.statusCode == 400) {
        print("ມີຂໍ້ມູນຫົວຫນ່ວຍນີ້ແລ້ວ Error ${respon.statusCode}");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("ແຈ້ງເຕືອນ"),
              content: Text("ມີຂໍ້ມູນຫົວຫນ່ວຍນີ້ແລ້ວ!"),
              actions: [
                TextButton(
                  onPressed: () {
                  Navigator.of(context).pop();
                  },
                  child: Text("ຕົກລົງ"),
                ),
              ],
            );
          },
        );
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
    txtsupid.text = "";
    txtsupname.text = "";
  }

  Future<void> fetchOne(String supid) async {
    final String urlone = "http://192.168.67.207:8000/tbsupplier/$supid";
    final respons = await http.get(Uri.parse(urlone));
    if (respons.statusCode == 200) {
      setState(() {
        data = json.decode(respons.body);
      });
    }
    print(data);
  }
  Widget TextCategory() {
    return Column(
      children: [
        TextField(
          controller: txtsupid,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ລະຫັດຜູ້ສະຫນອງ'),
              prefixIcon: Icon(
                Icons.book_rounded,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 4,
        ),
        TextField(
          controller: txtsupname,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ຊື່ຜູ້ສະຫນອງ'),
              prefixIcon: Icon(
                Icons.book,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 4,
        ),
         TextField(
          controller: txttel,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ເບີໂທຜູ້ສະຫນອງ'),
              prefixIcon: Icon(
                Icons.book_rounded,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 4,
        ),
         TextField(
          controller: txtemail,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ອີເມວຜູ້ສະຫນອງ'),
              prefixIcon: Icon(
                Icons.book_rounded,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 4,
        ),
         TextField(
          controller: txtcontract,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ຕິດຕໍ່ຜູ້ສະຫນອງ'),
              prefixIcon: Icon(
                Icons.book_rounded,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 4,
        ),
         TextField(
          controller: txttelcontract,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ເບີໂທຜູ້ຕິດຕໍ່ຜູ້ສະຫນອງ'),
              prefixIcon: Icon(
                Icons.book_rounded,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
        ),
        SizedBox(
          height: 4,
        ),
        
  
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 148, 226, 133),
                      elevation: 15,
                      shadowColor: Color.fromARGB(255, 61, 104, 56)),
                  onPressed: () {
                    if(supid !=""){
                      EditcatData(txtsupid.text, txtsupname.text);
                      ClearText();
                      
                    } else
                      AddcatData(txtsupid.text, txtsupname.text,txttel.text,txtemail.text,txtcontract.text,txttelcontract.text);
                      ClearText();
                      Navigator.of(context).pop();
                    
                    
                  },
                  child: Text(
                    'ບັນທຶກຂໍ້ມູນ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 223, 82, 82),
                      elevation: 15,
                      shadowColor: Color.fromARGB(255, 104, 56, 56)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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

  void Addcategory() {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            backgroundColor: Colors.amber,
            title: Text('ເພິ່ມຂໍ້ມູນ'),
            content: Text("ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບຖ້ວນ"),
            actions: [
              TextCategory(),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ຈັດການຂໍ້ມູນຜູ້ສະຫນອງ"),
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
                        getdata['supid'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        getdata['supname'],
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
                                supid ='${getdata['supid'].toString()}';
                                txtsupid.text = '${getdata['supid']}';
                                txtsupname.text = '${getdata['supname']}';
                        
                                Addcategory();
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
                                        title: Text("ລຶບຂໍ້ມູນຜູ້ສະຫນອງ"),
                                        content: Text(
                                            "ທ່ານຕ້ອງການລຶບຂໍ້ມູນນີ້ ຫຼື ບໍ່ [yes/no]"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                DeleteData("${getdata['supid']}");
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
          
          Addcategory();
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