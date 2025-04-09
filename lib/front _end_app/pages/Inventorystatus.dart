import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:theisi_app/front%20_end_app/componets/addproduct.dart';
import 'package:theisi_app/front%20_end_app/componets/listforproduct.dart';
import 'package:theisi_app/front%20_end_app/models/modeldata.dart';
import 'package:theisi_app/service/authservice.dart';
import 'package:theisi_app/service/database.dart';
import 'package:theisi_app/service/qrdatabase.dart';

class Analyticspage extends StatefulWidget {
  const Analyticspage({super.key});

  @override
  State<Analyticspage> createState() => _AnalyticspageState();
}

class _AnalyticspageState extends State<Analyticspage> {
  Databaseservices dbservice = Databaseservices();
  Qrdatabase rfid = Qrdatabase();
  String? dropdownvalue;
  bool? islinked;
  Map<String, dynamic>? qrinfo;

  List<String> sortby = [
    'Name',
    'Quantity',
    'Layer',
  ];

  List<bool> bottonshow = [];
  List<Modeldataforproducts> filtered = [];
  List<Modeldataforproducts> products = [];
  List<Map<String, dynamic>> rfidlist = [];
  String? seletedrfid;
  Authservice getcurrentrole = Authservice();
  String currentrole = '';

  final TextEditingController controller = TextEditingController();
  final TextEditingController addname = TextEditingController();
  final TextEditingController stocklvel = TextEditingController();
  final TextEditingController needtobestock = TextEditingController();
  final TextEditingController layernumber = TextEditingController();

  void fetchrole() async {
    String? role = await getcurrentrole.getuserrole();
    print("Fetched role: $role");
    if (role == 'Admin') {
      setState(() {
        currentrole = 'Admin';
      });
    } else if (role == 'Employee') {
      setState(() {
        currentrole = 'Employee';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('your are not either employee or admin of this store')),
      );
    }
  }

  void fetchQr() {
    rfid.getqr().listen(
      (qr) {
        List<Map<String, dynamic>> tempRfid = [];

        for (var rfids in qr.docs) {
          var data = rfids.data() as Map<String, dynamic>;
          var isliked = data['linked'];
          var qrValue = data['qr'];
          var qrid = rfids.id;

          tempRfid.add({
            'qr': qrValue,
            'islinked': isliked,
            'docid': qrid,
          });
        }

        setState(() {
          rfidlist = tempRfid;
        });
      },
      onError: (error) {},
    );
  }

  void fetchData() {
    dbservice.getProducts().listen((snapshot) {
      List<Modeldataforproducts> tempList = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Adding the product data along with the QR data from rfidlist at the given index
        tempList.add(
          Modeldataforproducts(
            qr: data['qr'],
            id: doc.id,
            name: data['name'] ?? '',
            resupply: data['restockvalue'] ?? 0,
            total: data['initalStock'] ?? 0,
            layer: data['layernumber'] ?? 0,
          ),
        );
      }

      // Update the UI with the fetched data
      setState(() {
        products = tempList;
        filtered = List.from(products);
        bottonshow = List.generate(filtered.length, (index) => false);
      });
    });
  }

  void deletefunction(String docid, String productinfo) async {
    // First, delete the product from the database
    dbservice.deleteproducts(docid);

    String? rfidDocId;
    bool? linked;

    // Look for the RFID matching the productinfo
    for (var id in rfidlist) {
      if (id['qr'] == productinfo) {
        rfidDocId = id['docid'];
        linked = id['islinked'];
        break;
      }
    }

    if (rfidDocId != null && linked != null) {
      rfid.updateqr(rfidDocId, !linked);
    } else {
      // Provide feedback if RFID is not found or linked value is missing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No matching RFID found for the product")),
      );
    }
  }

  void _addProduct(String docid) {
    setState(() {
      int stock = int.tryParse(stocklvel.text) ?? 0;
      int resupply = int.tryParse(needtobestock.text) ?? 0;
      int layer = int.tryParse(layernumber.text) ?? 0;

      dbservice.addproducts(
          addname.text, layer, resupply, stock, seletedrfid ?? 'no qr attach');
      rfid.updateqr(docid, true);
      // Clear input fields
      addname.clear();
      stocklvel.clear();
      needtobestock.clear();
      layernumber.clear();
      seletedrfid = null;
    });
  }

  Future<void> confirmationdelete(docid, String search) async {
    return showDialog(
        context: context,
        builder: (
          context,
        ) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure you want to delete this product?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  deletefunction(
                    docid,
                    search,
                  );

                  print('delete');
                },
                child: Text('Confirm'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  void fitlerfunction(String value) {
    setState(() {
      List<Modeldataforproducts> tempList = products
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();

      if (tempList.isNotEmpty) {
        filtered = tempList;
        bottonshow = List.generate(filtered.length, (index) => false);
      }
    });
  }

  Future<void> editfunction(index, docid) {
    final TextEditingController newname = TextEditingController();
    final TextEditingController newlayernum = TextEditingController();
    final TextEditingController newstock = TextEditingController();
    final TextEditingController stockstatus = TextEditingController();
    // final String editname = name;

    return showDialog(
        context: context,
        builder: (
          context,
        ) {
          return AlertDialog(
            content: Addproducts(
                currentstock: newstock,
                layernumber: newlayernum,
                name: newname,
                needstoberestock: stockstatus,
                rfid: rfidlist,
                seletedrfid: (value) {
                  setState(() {
                    seletedrfid = value;
                  });
                  print("Selected RFID: $seletedrfid");
                }),
            actions: [
              TextButton(
                onPressed: () {
                  String? docidOfRfid;
                  bool? islinked;

                  //unlinked the prev rfid and update the status
                  for (var updateqr in rfidlist) {
                    if (updateqr['qr'] == filtered[index].qr) {
                      docidOfRfid = updateqr['docid'];
                      islinked = updateqr['islinked'];
                      break;
                    }
                  }

                  if (docidOfRfid != null && islinked != null) {
                    rfid.updateqr(docidOfRfid, !islinked);
                  }

                  // check the update the new the new rfid that been selected
                  if (seletedrfid != null) {
                    String? docidofrfid;
                    bool? islinked;

                    for (var id in rfidlist) {
                      if (id['qr'] == seletedrfid) {
                        docidofrfid = id['docid'];
                        islinked = id['islinked'];
                        break;
                      }
                    }

                    if (docidofrfid != null && islinked != null) {
                      rfid.updateqr(docidofrfid, !islinked);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('no rfid attach')),
                      );
                    }
                  } else {
                    print("Error: No RFID selected.");
                  }
                  dbservice.updateproduct(
                    seletedrfid ?? 'no qravaible',
                    docid,
                    newname.text,
                    int.tryParse(newlayernum.text) ?? 0,
                    int.tryParse(newstock.text) ?? 0,
                    int.tryParse(stockstatus.text) ?? 0,
                  );
                  seletedrfid = null;
                  Navigator.pop(context);
                },
                child: Text('Save changes'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    filtered = products;
    fetchData();
    fetchQr();
  }

  @override
  Widget build(BuildContext context) {
    double screenwitdh = MediaQuery.of(context).size.width;
    // double screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF2C2E31),
      body: SafeArea(
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            color: Color(0xFF2D3641),
            child: Row(
              children: [
                Text(
                  'Inventory Status',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(5),
                      // width: 250, // Adjusted width
                      child: TextFormField(
                        onChanged: (value) {
                          fitlerfunction(value);
                        },
                        enableSuggestions: true,
                        controller: controller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'search for a product',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton2(
                        value: dropdownvalue,
                        buttonStyleData: ButtonStyleData(
                          width: screenwitdh * .30,
                          height: 30,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        hint: Text(
                          'Sort by',
                          style: TextStyle(fontSize: 10),
                        ),
                        dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            offset: Offset(0, -10)),
                        onChanged: (value) => {
                              setState(() {
                                dropdownvalue = value;
                              }),
                            },
                        items: sortby
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ))
                            .toList()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            width: screenwitdh * .15,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: screenwitdh * .15,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Resupply',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              addAutomaticKeepAlives: false,
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < filtered.length; i++) {
                        bottonshow[i] = (i == index) ? !bottonshow[i] : false;
                      }
                    });
                  },
                  child: ProductList(
                    currentrole: currentrole,
                    nameOfProduct: filtered[index].name,
                    quantityOfProduct: filtered[index].total,
                    restockOfProduct: filtered[index].resupply,
                    layernumber: filtered[index].layer,
                    edit: () async => editfunction(index, filtered[index].id),
                    showbotton: bottonshow[index],
                    delete: () async => confirmationdelete(
                      filtered[index].id,
                      filtered[index].qr ?? 'nodata been found',
                    ),
                  ),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              print(rfidlist);
              print(seletedrfid);
              print(currentrole);
            },
            child: Text('pressme'),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add a product'),
              content: Addproducts(
                currentstock: stocklvel,
                layernumber: layernumber,
                name: addname,
                needstoberestock: needtobestock,
                rfid: rfidlist,
                seletedrfid: (value) {
                  setState(() {
                    seletedrfid = value;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (seletedrfid != null) {
                      String? docidofrfid;

                      for (var id in rfidlist) {
                        if (id['qr'] == seletedrfid) {
                          docidofrfid = id['docid'];

                          break;
                        }
                      }

                      if (docidofrfid != null) {
                        _addProduct(docidofrfid); // Use docidofrfid here
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('no rfid attach')),
                        );
                      }
                    } else {
                      print("Error: No RFID selected.");
                    }
                  },
                  child: Text('submit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('close'),
                )
              ],
            ),
          );
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
