class CityModel {
  final int? cityId;
  final String? name;
  final String? avatarUrl;

  CityModel({this.cityId, this.name, this.avatarUrl});
  
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json['id'],
      name: json['nome'],
    );
  }
}
