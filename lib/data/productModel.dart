// product_model.dart

enum AvailabilityStatus { IN_STOCK, LOW_STOCK }

enum Category { BEAUTY, FRAGRANCES, FURNITURE, GROCERIES }

enum ReturnPolicy {
  NO_RETURN_POLICY,
  THE_30_DAYS_RETURN_POLICY,
  THE_60_DAYS_RETURN_POLICY,
  THE_7_DAYS_RETURN_POLICY,
  THE_90_DAYS_RETURN_POLICY,
}

class Products {
  List<Product> products;
  int total;
  int skip;
  int limit;

  Products({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      products:
          (json['products'] as List).map((p) => Product.fromJson(p)).toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}

class Product {
  int id;
  String title;
  String description;
  Category category;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  List<String> tags;
  String? brand;
  String sku;
  int weight;
  Dimensions dimensions;
  String warrantyInformation;
  String shippingInformation;
  AvailabilityStatus availabilityStatus;
  List<Review> reviews;
  ReturnPolicy returnPolicy;
  int minimumOrderQuantity;
  Meta meta;
  List<String> images;
  String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: _parseCategory(json['category']),
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'],
      tags: List<String>.from(json['tags']),
      brand: json['brand'],
      sku: json['sku'],
      weight: json['weight'],
      dimensions: Dimensions.fromJson(json['dimensions']),
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: _parseAvailability(json['availabilityStatus']),
      reviews:
          (json['reviews'] as List).map((r) => Review.fromJson(r)).toList(),
      returnPolicy: _parseReturnPolicy(json['returnPolicy']),
      minimumOrderQuantity: json['minimumOrderQuantity'],
      meta: Meta.fromJson(json['meta']),
      images: List<String>.from(json['images']),
      thumbnail: json['thumbnail'],
    );
  }

  static Category _parseCategory(String value) {
    switch (value.toLowerCase()) {
      case 'beauty':
        return Category.BEAUTY;
      case 'fragrances':
        return Category.FRAGRANCES;
      case 'furniture':
        return Category.FURNITURE;
      case 'groceries':
        return Category.GROCERIES;
      default:
        return Category.GROCERIES;
    }
  }

  static AvailabilityStatus _parseAvailability(String value) {
    switch (value.toLowerCase()) {
      case 'in_stock':
        return AvailabilityStatus.IN_STOCK;
      case 'low_stock':
        return AvailabilityStatus.LOW_STOCK;
      default:
        return AvailabilityStatus.IN_STOCK;
    }
  }

  static ReturnPolicy _parseReturnPolicy(String value) {
    switch (value.toLowerCase()) {
      case 'no_return_policy':
        return ReturnPolicy.NO_RETURN_POLICY;
      case 'the_30_days_return_policy':
        return ReturnPolicy.THE_30_DAYS_RETURN_POLICY;
      case 'the_60_days_return_policy':
        return ReturnPolicy.THE_60_DAYS_RETURN_POLICY;
      case 'the_7_days_return_policy':
        return ReturnPolicy.THE_7_DAYS_RETURN_POLICY;
      case 'the_90_days_return_policy':
        return ReturnPolicy.THE_90_DAYS_RETURN_POLICY;
      default:
        return ReturnPolicy.NO_RETURN_POLICY;
    }
  }
}

class Dimensions {
  double width;
  double height;
  double depth;

  Dimensions({required this.width, required this.height, required this.depth});

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
    );
  }
}

class Meta {
  DateTime createdAt;
  DateTime updatedAt;
  String barcode;
  String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      barcode: json['barcode'],
      qrCode: json['qrCode'],
    );
  }
}

class Review {
  int rating;
  String comment;
  DateTime date;
  String reviewerName;
  String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}
