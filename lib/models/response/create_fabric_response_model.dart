class CreateFabricResponseModel {
  final Fabric fabric;
  final List<PatternPiece> patternPieces;

  CreateFabricResponseModel({
    required this.fabric,
    required this.patternPieces,
  });

  factory CreateFabricResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateFabricResponseModel(
      fabric: Fabric.fromJson(json['fabric']),
      patternPieces: (json['pattern_pieces'] as List)
          .map((piece) => PatternPiece.fromJson(piece))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fabric': fabric,
      'pattern_pieces': patternPieces.map((piece) => piece.toJson()).toList(),
    };
  }
}

class Fabric {
  final int designId;
  final int width;
  final int height;
  final int numOfPieces;
  final dynamic cutPositions;
  final String updatedAt;
  final String createdAt;
  final int id;

  Fabric({
    required this.designId,
    required this.width,
    required this.height,
    required this.numOfPieces,
    this.cutPositions,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Fabric.fromJson(Map<String, dynamic> json) {
    return Fabric(
      designId: json['design_id'],
      width: json['width'],
      height: json['height'],
      numOfPieces: json['num_of_pieces'],
      cutPositions: json['cut_positions'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'design_id': designId,
      'width': width,
      'height': height,
      'num_of_pieces': numOfPieces,
      'cut_positions': cutPositions,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}

class PatternPiece {
  final String pieceId;
  final int qty;
  final Outline outline;

  PatternPiece({
    required this.pieceId,
    required this.qty,
    required this.outline,
  });

  factory PatternPiece.fromJson(Map<String, dynamic> json) {
    return PatternPiece(
      pieceId: json['piece_id'],
      qty: json['qty'],
      outline: Outline.fromJson(json['outline']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'piece_id': pieceId,
      'qty': qty,
      'outline': outline.toJson(),
    };
  }
}

class Outline {
  final String format;
  final List<double> x;
  final List<double> y;

  Outline({
    required this.format,
    required this.x,
    required this.y,
  });

  factory Outline.fromJson(Map<String, dynamic> json) {
    return Outline(
      format: json['format'],
      x: (json['x'] as List).map<double>((e) => e.toDouble()).toList(),
      y: (json['y'] as List).map<double>((e) => e.toDouble()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'format': format,
      'x': x,
      'y': y,
    };
  }
}
