
class ImageModel {
  ImageModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  final List<Product>? products;
  final int? total;
  final int? skip;
  final int? limit;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<Product>.from(products!.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Product {
  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });

  final int? id;
  final String? title;
  final String? description;
  final int? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String? brand;
  final String? category;
  final String ?thumbnail;
  final List<String> ?images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    discountPercentage: json["discountPercentage"].toDouble(),
    rating: json["rating"].toDouble(),
    stock: json["stock"],
    brand: json["brand"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "category": category,
    "thumbnail": thumbnail,
    "images": List<String>.from(images!.map((x) => x)),
  };
}

class Person {
  Person({
    this.id,
    this.name,
    this.email,
    this.photoUrl
  });

  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    photoUrl: json["photoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "photoUrl": photoUrl,
  };
}