class NewDesignModel {
  final String sleeveType;
  final String collarType;
  final String color;
  final String fabricType;

  NewDesignModel({
    required this.sleeveType,
    required this.collarType,
    required this.color,
    required this.fabricType,
  });

  factory NewDesignModel.fromJson(Map<String, dynamic> json) {
    return NewDesignModel(
      sleeveType: json['sleeve_type'] ?? '',
      collarType: json['collar_type'] ?? '',
      color: json['color'] ?? '',
      fabricType: json['fabric_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sleeve_type': sleeveType,
      'collar_type': collarType,
      'color': color,
      'fabric_type': fabricType,
    };
  }
}

class DesignList {
  final List<NewDesignModel> designs;

  DesignList({required this.designs});

  factory DesignList.fromJson(Map<String, dynamic> json) {
    var designsList = json['designs'] as List;
    List<NewDesignModel> NewdesignModelList = designsList
        .map((designJson) => NewDesignModel.fromJson(designJson))
        .toList();

    return DesignList(designs: NewdesignModelList);
  }

  Map<String, dynamic> toJson() {
    return {'designs': designs.map((design) => design.toJson()).toList()};
  }
}
