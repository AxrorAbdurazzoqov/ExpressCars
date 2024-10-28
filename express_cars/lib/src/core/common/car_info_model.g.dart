// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarInfoModelAdapter extends TypeAdapter<CarInfoModel> {
  @override
  final int typeId = 1;

  @override
  CarInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarInfoModel(
      carId: fields[0] as String,
      brand: fields[1] as String,
      type: fields[2] as String,
      name: fields[3] as String,
      model: fields[4] as String,
      year: fields[5] as int,
      available: fields[6] as bool,
      pricePerDay: fields[7] as int,
      pricePerWeek: fields[8] as int,
      pricePerMonth: fields[9] as int,
      imageUrl: fields[10] as String,
      features: fields[11] as Features,
      reviews: (fields[12] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, CarInfoModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.carId)
      ..writeByte(1)
      ..write(obj.brand)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.model)
      ..writeByte(5)
      ..write(obj.year)
      ..writeByte(6)
      ..write(obj.available)
      ..writeByte(7)
      ..write(obj.pricePerDay)
      ..writeByte(8)
      ..write(obj.pricePerWeek)
      ..writeByte(9)
      ..write(obj.pricePerMonth)
      ..writeByte(10)
      ..write(obj.imageUrl)
      ..writeByte(11)
      ..write(obj.features)
      ..writeByte(12)
      ..write(obj.reviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FeaturesAdapter extends TypeAdapter<Features> {
  @override
  final int typeId = 2;

  @override
  Features read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Features(
      seats: fields[0] as int,
      engine: fields[1] as int,
      fuelType: fields[2] as String,
      airConditioner: fields[3] as bool,
      transmission: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Features obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.seats)
      ..writeByte(1)
      ..write(obj.engine)
      ..writeByte(2)
      ..write(obj.fuelType)
      ..writeByte(3)
      ..write(obj.airConditioner)
      ..writeByte(4)
      ..write(obj.transmission);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeaturesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
