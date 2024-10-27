import 'package:express_cars/src/core/common/car_info_model.dart';

class BrandModel {
    final String name;
    final String image;
    final List<CarInfoModel> avaible;

    BrandModel({
        required this.name,
        required this.image,
        required this.avaible,
    });

    factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        name: json["name"],
        image: json["image"],
        avaible: List<CarInfoModel>.from(json["avaible"].map((mp) => CarInfoModel.fromJson(mp))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "avaible": List<dynamic>.from(avaible.map((mp) => mp.toJson())),
    };
}