import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList(
      {super.key,
      required this.currentrole,
      required this.nameOfProduct,
      required this.quantityOfProduct,
      required this.restockOfProduct,
      this.imageUrl,
      required this.edit,
      required this.layernumber,
      required this.showbotton,
      required this.delete});

  final String nameOfProduct;
  final int quantityOfProduct;
  final int restockOfProduct;
  final int layernumber;
  final String? imageUrl; // Allow dynamic image URL
  final bool showbotton;
  final Future<void> Function() edit;
  final Future<void> Function() delete;
  final String currentrole;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Color textcolor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xFF2D3641),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: widget.imageUrl != null
                    ? Image.network(
                        widget.imageUrl!,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.broken_image_rounded,
                        size: 60,
                      ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nameOfProduct,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textcolor,
                        ),
                      ),
                      Text(
                        'layer place it ${widget.layernumber}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: textcolor),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${widget.quantityOfProduct}',
                    style: TextStyle(
                      color: textcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  // padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '${widget.restockOfProduct}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textcolor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (widget.showbotton)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          print("Locate clicked");
                        },
                        icon: Icon(Icons.search, color: Colors.white),
                        label: Text("LOCATE",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    widget.currentrole == 'Admin'
                        ? Expanded(
                            child: ElevatedButton.icon(
                              onPressed: widget.edit,
                              icon: Icon(Icons.edit, color: Colors.white),
                              label: Text("EDIT",
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    SizedBox(width: 10),
                    widget.currentrole == 'Admin'
                        ? Expanded(
                            child: ElevatedButton.icon(
                              onPressed: widget.delete,
                              icon: Icon(Icons.delete, color: Colors.white),
                              label: Text("DELETE",
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 0,
                            height: 0,
                          ),
                  ],
                ),
              ],
            ),
          )
      ]),
    );
  }
}
