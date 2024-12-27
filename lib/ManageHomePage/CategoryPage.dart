import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class categoryPage extends StatefulWidget {
  const categoryPage({super.key});

  @override
  State<categoryPage> createState() => _categoryPageState();
}

class _categoryPageState extends State<categoryPage> {
   String catid="";


  var f = NumberFormat("#,##0.00");

  TextEditingController txtsearch = TextEditingController();


  TextEditingController txtcatid = TextEditingController();
  TextEditingController txtcatname = TextEditingController();

  List data = [];
  final String url =
      "http://localhost:8000/category";
  void initState() {
    fetchAllData();
    fetchOne("");
    txtsearch.text = "";
    txtcatname.text = "";
    txtcatid.text = "";
    fetchCategory(); 
    super.initState();
  }

  @override
  void dispose() {
    txtsearch.dispose();
    txtcatname.dispose();
    txtcatid.dispose();

    super.dispose();
  }
  List datacatch=[];

  Future<void> fetchCategory() async{
    try{
      final String urlcatrgory="http://localhost:8000/category";
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
  Future<void> DeleteData(String catid) async {
    try {
      final String urldelete = "http://localhost:8000/category/$catid";
      final respon = await http.delete(Uri.parse(urldelete));
      if (respon.statusCode == 200) {
        print("ລຶບຂໍ້ມູນແລ້ວ ${respon.body}");
      } else {
        print("ບໍ່ສາມາດລຶບຂໍ້ມູນ ${respon.statusCode}");
      }
      fetchAllData();
    } catch (e) {}
  }

  Future<void> EditcatData(String catid, String catname) async {
    try {
      final String urledit = "http://localhost:8000/category/$catid";
      final respon = await http.put(Uri.parse(urledit),
          headers: {"content-type": "application/json"},
          body: json.encode({
            
            "catname": catname,
          }));

      if (respon.statusCode == 200) {
        print("ແກ້ໄຂຂໍ້ມູນແລ້ວ ${respon.body}");
      } else {
        print("ເກີດຂໍ້ຜິດພາດ ${respon.statusCode}");
      }

      fetchAllData();
      catid="";
    } catch (e) {
      print(e);
    }
  }

  Future<void> AddcatData(
      String catid, String catname) async {
    try {
      final String urladd = "http://localhost:8000/category";
      final respon = await http.post(Uri.parse(urladd),
          headers: {"content-type": "application/json"},
          body: json.encode({
            "catid": catid.toString(),
            "catname": catname,
          }));

      setState(() {
        if (respon.statusCode == 200) {
        print("ບັນທຶກຂໍ້ມູນແລ້ວ ${respon.body}");
        catid="";
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
    txtcatid.text = "";
    txtcatname.text = "";
  }

  Future<void> fetchOne(String catid) async {
    final String urlone = "http://localhost:8000/category/$catid";
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
          controller: txtcatid,
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
          height: 10,
        ),
        TextField(
          controller: txtcatname,
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
          height: 10,
        ),
        
  
        SizedBox(
          height: 10,
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
                    if(catid !=""){
                      EditcatData(txtcatid.text, txtcatname.text);
                      ClearText();
                      
                    } else
                      AddcatData(txtcatid.text, txtcatname.text);
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
                        getdata['catid'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        getdata['catname'],
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
                                catid ='${getdata['catid'].toString()}';
                                txtcatid.text = '${getdata['catid']}';
                                txtcatname.text = '${getdata['catname']}';
                        
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
                                        title: Text("ລຶບຂໍ້ມູນປື້ມ"),
                                        content: Text(
                                            "ທ່ານຕ້ອງການລຶບຂໍ້ມູນນີ້ ຫຼື ບໍ່ [yes/no]"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                DeleteData("${getdata['catid']}");
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