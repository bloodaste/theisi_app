class Modeldataforproducts {
  String name;
  int resupply;
  int total;
  int layer;
  String id;
  String? qr;

  Modeldataforproducts({
    required this.name,
    required this.id,
    this.qr,
    required this.resupply,
    required this.total,
    required this.layer,
  });
}
