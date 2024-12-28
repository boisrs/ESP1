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

   String? _selectItem;
   String? _selectItemunit;
   String? _selectItemcate;


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
      "http://192.168.67.207:8000/tbproducts";
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

    fetchtbsupplier();
    fetchtbunit();
    fetchCategory(); 
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
  List supplierData = [];
  List unitData = [];
  List datacatch = [];
  List productData = [];

  Future<void> fetchtbsupplier() async{
    try{
      final String urltbproducts="http://192.168.67.207:8000/tbsupplier";
      final respond = await http.get(Uri.parse(urltbproducts));

      if(respond.statusCode==200){
        supplierData.clear();
        setState(() {
          
          supplierData = json.decode(respond.body);
        });
      }
    print(supplierData);
    }catch(e){
      print(e);
    }
  }
  Future<void> fetchtbunit() async{
    try{
      final String urltbproducts="http://192.168.67.207:8000/tbunit";
      final respond = await http.get(Uri.parse(urltbproducts));

      if(respond.statusCode==200){
        unitData.clear();
        setState(() {
          
          unitData = json.decode(respond.body);
        });
      }
    print(unitData);
    }catch(e){
      print(e);
    }
  }
  Future<void> DeleteData(String proID,) async {
    try {
      final String urldelete = "http://192.168.67.207:8000/tbproducts/$proID";
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
      final String urledit = "http://192.168.67.207:8000/tbproducts/$proID";
      final respon = await http.put(Uri.parse(urledit),
          headers: {"content-type": "application/json"},
          body: json.encode({
          "proID": proID,
          "proname": proname,
          "qty": qty.toString(), 
          "imprice": imprice.toString(), 
          "saleprice": saleprice.toString(), 
          "supid": supid.toString(), 
          "level": level,
          "uid": uid.toString(), 
          "catid": catid.toString() 
        }));

      if (respon.statusCode == 200) {
        print("ແກ້ໄຂຂໍ້ມູນແລ້ວ ${respon.body}");
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
      proID="";
    } catch (e) {
      print(e);
    }
  }

  Future<void> AddcatData(
      String proID, String proname, String qty, String imprice,String saleprice, String supid, String level,String uid,String catid) async {
     try {
      final String urladd = "http://192.168.67.207:8000/tbproducts";
      final respon = await http.post(Uri.parse(urladd),
        headers: {"content-type": "application/json"},
        body: json.encode({
          "proname": proname,
          "qty": qty.toString(), 
          "imprice": imprice.toString(), 
          "saleprice": saleprice.toString(), 
          "supid": supid.toString(), 
          "level": level,
          "uid": uid.toString(), 
          "catid": catid.toString() 
        }));

      setState(() {
      if (respon.statusCode == 200) {
        print("ບັນທຶກຂໍ້ມູນແລ້ວ ${respon.body}");
        uid = "";
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
    txtproID.text = "";
    txtproname.text = "";
    txtqty.text = "";
    txtimprice.text = "";
    txtsaleprice.text = "";
    _selectItem = null;
    txtlevel.text = "";
    _selectItemunit = null;
    _selectItemcate = null;
  }

  Future<void> fetchOne(String proID) async {
    final String urlone = "http://192.168.67.207:8000/tbproducts/$proID";
    final respons = await http.get(Uri.parse(urlone));
    if (respons.statusCode == 200) {
      setState(() {
        data = json.decode(respons.body);
      });
    }
    print(data);
  }




  Future<void> fetchCategory() async {
  try {
    final String urlcatrgory = "http://192.168.67.207:8000/category";
    final response = await http.get(Uri.parse(urlcatrgory));

    if (response.statusCode == 200) {
      final List<dynamic> categoryData = json.decode(response.body);
      setState(() {
        datacatch = categoryData;
      });
      print(datacatch); // Debug: check the data
    } else {
      print("Failed to load categories: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching categories: $e");
  }
}
Widget Loadsupplier(setState){
    return StatefulBuilder(
      builder: (context,setState) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(color: Colors.black,width: 1)
          ),
          child: DropdownButton(
            isExpanded: true,
            hint: Text("ກະລຸນາເລືອກຜູ້ສະໜອງ"),
            value: _selectItem,
            items: supplierData.map((cat){
            return DropdownMenuItem(
              value: cat['supid'].toString(),
              child: Text('${cat['supname']}'));
            }).toList(),
            onChanged: (val){
              setState(() {
                _selectItem = val;
              });
              this.setState((){
                _selectItem = val;
              });
              print(_selectItem);
            }),
        );
      }
    );
  }
 Widget Loadunit(setState){
    return StatefulBuilder(
      builder: (context,setState) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(color: Colors.black,width: 1)
          ),
          child: DropdownButton(
            isExpanded: true,
            hint: Text("ກະລຸນາເລືອກຫົວໜ່ວຍ"),
            value: _selectItemunit,
            items: unitData.map((cat){
            return DropdownMenuItem(
              value: cat['uid'].toString(),
              child: Text('${cat['uname']}'));
            }).toList(),
            onChanged: (val){
              setState(() {
                _selectItemunit = val;
              });
              this.setState((){
                _selectItemunit = val;
              });
              print(_selectItemunit);
            }),
        );
      }
    );
  }
 Widget LoadCategory(setState){
    return StatefulBuilder(
      builder: (context,setState) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(color: Colors.black,width: 1)
          ),
          child: DropdownButton(
            isExpanded: true,
            hint: Text("ກະລຸນາເລືອກປະເພດສິນຄ້າ"),
            value: _selectItemcate,
            items: datacatch.map((cat){
            return DropdownMenuItem(
              value: cat['catid'].toString(),
              child: Text('${cat['catname']}'));
            }).toList(),
            onChanged: (val){
              setState(() {
                _selectItemcate = val;
              });
              this.setState((){
                _selectItemcate = val;
              });
              print(_selectItemcate);
            }),
        );
      }
    );
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
          height: 10,
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
          height: 10,
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
          height: 10,
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
          height: 10,
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
          height: 10,
        ),
        Loadsupplier(setState),
        SizedBox(
          height: 10,
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
          height: 10,
        ),
        Loadunit(setState),
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
              width: 110,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 148, 226, 133),
                      elevation: 15,
                      shadowColor: Color.fromARGB(255, 61, 104, 56)),
                  onPressed: () {
                    if(proid !=""){
                      EditcatData(txtproID.text, txtproname.text,txtqty.text,txtimprice.text,txtsaleprice.text,_selectItem.toString(),txtlevel.text,_selectItemunit.toString(),_selectItemcate.toString());
                      ClearText();
                      
                    } else
                      AddcatData(txtproID.text, txtproname.text,txtqty.text,txtimprice.text,txtsaleprice.text,_selectItem.toString(),txtlevel.text,_selectItemunit.toString(),_selectItemcate.toString());
                      Navigator.of(context).pop();
                      ClearText();
                    
                    
                  },
                  child: Text(
                    'ບັນທຶກ',
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
              width: 110,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 223, 82, 82),
                      elevation: 15,
                      shadowColor: Color.fromARGB(255, 104, 56, 56)),
                  onPressed: () {
                     Navigator.of(context).pop();
                     ClearText();
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

  void Addtbproducts() {
  showDialog(
    context: context,
    builder: (c) {
      return AlertDialog(
        backgroundColor: Colors.amber,
        title: Text('ເພິ່ມຂໍ້ມູນ'),
        content: SizedBox(
          
          child: SingleChildScrollView( 
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
                                _selectItem = '${getdata['supid']}';
                                txtlevel.text = '${getdata['level']}';
                                _selectItemunit = '${getdata['uid']}';
                                _selectItemcate = '${getdata['catid']}';
                              
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