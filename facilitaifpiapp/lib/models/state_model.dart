class StateModel {
  final int? stateId;
  final String? abbreviation;
  final String? name;
  final String? avatarUrl;

  StateModel({this.stateId, this.abbreviation, this.name, this.avatarUrl});
  
  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      stateId: json['id'],
      abbreviation: json['sigla'],
      name: json['nome'],
    );
  }
}
