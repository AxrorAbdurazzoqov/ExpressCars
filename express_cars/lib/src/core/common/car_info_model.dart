class CarInfoModel {
    final String carId;
    final String brand;
    final String type;
    final String name;
    final String model;
    final int year;
    final bool available;
    final int pricePerDay;
    final int pricePerWeek;
    final int pricePerMonth;
    final String imageUrl;
    final Features features;
    final List<int> reviews;

    CarInfoModel({
        required this.carId,
        required this.brand,
        required this.type,
        required this.name,
        required this.model,
        required this.year,
        required this.available,
        required this.pricePerDay,
        required this.pricePerWeek,
        required this.pricePerMonth,
        required this.imageUrl,
        required this.features,
        required this.reviews,
    });

    factory CarInfoModel.fromJson(Map<String, dynamic> json) => CarInfoModel(
        carId: json["car_id"],
        brand: json["brand"],
        type: json["type"],
        name: json["name"],
        model: json["model"],
        year: json["year"],
        available: json["available"],
        pricePerDay: json["price_per_day"],
        pricePerWeek: json["price_per_week"],
        pricePerMonth: json["price_per_month"],
        imageUrl: json["image_url"],
        features: Features.fromJson(json["features"]),
        reviews: List<int>.from(json["reviews"].map((mp) => mp)),
    );

    Map<String, dynamic> toJson() => {
        "car_id": carId,
        "brand": brand,
        "type": type,
        "name": name,
        "model": model,
        "year": year,
        "available": available,
        "price_per_day": pricePerDay,
        "price_per_week": pricePerWeek,
        "price_per_month": pricePerMonth,
        "image_url": imageUrl,
        "features": features.toJson(),
        "reviews": List<dynamic>.from(reviews.map((mp) => mp)),
    };
}

class Features {
    final int seats;
    final int engine;
    final String fuelType;
    final bool airConditioner;
    final String transmission;

    Features({
        required this.seats,
        required this.engine,
        required this.fuelType,
        required this.airConditioner,
        required this.transmission,
    });

    factory Features.fromJson(Map<String, dynamic> json) => Features(
        seats: json["seats"],
        engine: json["engine"],
        fuelType: json["fuel_type"],
        airConditioner: json["air_conditioner"],
        transmission: json["transmission"],
    );

    Map<String, dynamic> toJson() => {
        "seats": seats,
        "engine": engine,
        "fuel_type": fuelType,
        "air_conditioner": airConditioner,
        "transmission": transmission,
    };
}