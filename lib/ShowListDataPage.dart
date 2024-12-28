import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ShowListDataPage extends StatefulWidget {
  const ShowListDataPage({super.key});

  @override
  State<ShowListDataPage> createState() => _ShowListDataPageState();
}

class _ShowListDataPageState extends State<ShowListDataPage> {
  String bid="";
  String? _selectItem;

  var f = NumberFormat("#,##0.00");

  TextEditingController txtsearch = TextEditingController();

  TextEditingController txtid = TextEditingController();
  TextEditingController txtbname = TextEditingController();
  TextEditingController txtbprice = TextEditingController();
  TextEditingController txtbpage = TextEditingController();
  TextEditingController txtcatid = TextEditingController();

  List data = [];
  final String url =
      "http://localhost:8000/book"; //ລັນໃນເຄື່ອງໃຫ້ໃສ local EX: http://localhost:8000/book //
  //ລັນຢູ່ເຄື່ອງອື່ນໃສ່ IP ຂອງເຕື່ອງນັ້ນໆ EX :http://192.168.253.54:8000/book //

  @override
  void initState() {
    fetchAllData();
    fetchOne("");
    txtsearch.text = "";
    txtbname.text = "";
    txtbprice.text = "";
    txtid.text = "";
    fetchCategory(); 
    super.initState();
  }

  @override
  void dispose() {
    txtsearch.dispose();
    txtbname.dispose();
    txtbprice.dispose();
    txtid.dispose();

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
  Future<void> DeleteData(String bid) async {
    try {
      final String urldelete = "http://localhost:8000/book/$bid";
      final respon = await http.delete(Uri.parse(urldelete));
      if (respon.statusCode == 200) {
        print("ລຶບຂໍ້ມູນແລ້ວ ${respon.body}");
      } else {
        print("ບໍ່ສາມາດລຶບຂໍ້ມູນ ${respon.statusCode}");
      }
      fetchAllData();
    } catch (e) {}
  }

  Future<void> EditBookData(String bid, String bname, String bprice, String bpage,String catid) async {
    try {
      final String urledit = "http://localhost:8000/book/$bid";
      final respon = await http.put(Uri.parse(urledit),
          headers: {"content-type": "application/json"},
          body: json.encode({
            
            "bookname": bname,
            "bprice": bprice,
            "bpage": bpage,
            "catid":catid
          }));

      if (respon.statusCode == 200) {
        print("ແກ້ໄຂຂໍ້ມູນແລ້ວ ${respon.body}");
      } else {
        print("ເກີດຂໍ້ຜິດພາດ ${respon.statusCode}");
      }

      fetchAllData();
      bid="";
    } catch (e) {
      print(e);
    }
  }

  Future<void> AddBookData(
      String bid, String bname, String bprice, String bpage, String catid) async {
    try {
      final String urladd = "http://localhost:8000/book";
      final respon = await http.post(Uri.parse(urladd),
          headers: {"content-type": "application/json"},
          body: json.encode({
            "bid": bid,
            "bookname": bname,
            "bprice": bprice,
            "bpage": bpage,
            "catid": catid
          }));

      setState(() {
        if (respon.statusCode == 200) {
        print("ບັນທຶກຂໍ້ມູນແລ້ວ ${respon.body}");
        bid="";
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
    txtid.text = "";
    txtbname.text = "";
    txtbprice.text = "";
    txtbpage.text = "";
  }

  Future<void> fetchOne(String bid) async {
    final String urlone = "http://172.20.10.4:8000/book/$bid";
    final respons = await http.get(Uri.parse(urlone));
    if (respons.statusCode == 200) {
      setState(() {
        data = json.decode(respons.body);
      });
    }
    print(data);
  }


  String ? selectdata;
  Widget LoadCategory(setState){
    
    return  Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(color: Colors.black,width: 1)
      ),
      child: DropdownButton(
        isExpanded: true,
        hint: Text("ກະລຸນາເລືອກປະເພດປື້ມ"),
        value: _selectItem,
        items: datacatch.map((cat){
        return DropdownMenuItem(
          value: cat['catid'].toString(),
          child: Text('${cat['catname']}'));
        }).toList(),
        onChanged: (val){
          setState(() {
            _selectItem = val;
          });
          
          print(_selectItem);
        }),
    );
  }
  

  Widget TextBook() {
    return Column(
      children: [
        TextField(
          controller: txtid,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ລະຫັດປຶ້ມ'),
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
          controller: txtbname,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ລາຍການປຶ້ມ'),
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
        TextField(
          controller: txtbprice,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ລາຄາ'),
              prefixIcon: Icon(
                Icons.currency_exchange_outlined,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
          keyboardType: TextInputType.number, ////////ໃຫ້ຄີບອດເປັນແຕ່ຕົວເລກ
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: txtbpage,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text('ຈຳນວນຫນ້າ'),
              prefixIcon: Icon(
                Icons.numbers,
                color: Colors.blue,
                size: 25,
              ),
              filled: true,
              fillColor: Colors.white),
          keyboardType: TextInputType.number, ////////ໃຫ້ຄີບອດເປັນແຕ່ຕົວເລກ
        ),
        SizedBox(
          height: 10,
        ),
        LoadCategory(setState),
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
                    if(bid !=""){
                      EditBookData(txtid.text, txtbname.text, txtbprice.text,txtbpage.text,_selectItem.toString());
                      ClearText();
                      
                    } else
                      AddBookData(txtid.text, txtbname.text, txtbprice.text,txtbpage.text,_selectItem.toString());
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

  void AddBook() {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            backgroundColor: Colors.amber,
            title: Text('ເພິ່ມຂໍ້ມູນ'),
            content: Text("ກະລຸນາປ້ອນຂໍ້ມູນປື້ມໃຫ້ຄົບຖ້ວນ"),
            actions: [
              TextBook(),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ຈັດການຂໍ້ມູນປື້ມ"),
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
                        getdata['bid'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        getdata['bookname'],
                        style: TextStyle(
                            color: Colors.blue.shade300,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        f.format(getdata['bprice']).toString(),
                        style: TextStyle(
                            color: Colors.red.shade300,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                bid ='${getdata['bid']}';
                                txtid.text = '${getdata['bid']}';
                                txtbname.text = '${getdata['bookname']}';
                                txtbprice.text = '${getdata['bprice']}';
                                txtbpage.text = '${getdata['bpage']}';
                                _selectItem = '${getdata['catid']}';
                                AddBook();
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
                                                DeleteData("${getdata['bid']}");
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
          
          AddBook();
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
