class Product {
  int productId;
  String images;
  String mrp;
  String discount;
  String afterPrice;
  String title;
  int category;

  Product(
      {this.productId,
        this.images,
        this.mrp,
        this.discount,
        this.afterPrice,
        this.title,
        this.category});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    images = json['images'];
    mrp = json['mrp'];
    discount = json['discount'];
    afterPrice = json['after_price'];
    title = json['title'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['images'] = this.images;
    data['mrp'] = this.mrp;
    data['discount'] = this.discount;
    data['after_price'] = this.afterPrice;
    data['title'] = this.title;
    data['category'] = this.category;
    return data;
  }
}
