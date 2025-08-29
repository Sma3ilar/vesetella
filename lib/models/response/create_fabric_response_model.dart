import 'dart:convert';

class CreateFabricResponseModel {
  final Fabric fabric;
  final List<PatternPiece> patternPieces;

  CreateFabricResponseModel({required this.fabric, required this.patternPieces});

  factory CreateFabricResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateFabricResponseModel(
      fabric: Fabric.fromJson(json['fabric'] as Map<String, dynamic>),
      patternPieces: (json['pattern_pieces'] as List<dynamic>)
          .map((e) => PatternPiece.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'fabric': fabric.toJson(),
        'pattern_pieces': patternPieces.map((e) => e.toJson()).toList(),
      };

  static CreateFabricResponseModel fromJsonString(String source) =>
      CreateFabricResponseModel.fromJson(json.decode(source));
}

class Fabric {
  final int designId;
  final int width;
  final int height;
  final dynamic cutPositions; // keep dynamic/null for now
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Fabric({
    required this.designId,
    required this.width,
    required this.height,
    this.cutPositions,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Fabric.fromJson(Map<String, dynamic> json) {
    return Fabric(
      designId: json['design_id'] as int,
      width: json['width'] as int,
      height: json['height'] as int,
      cutPositions: json['cut_positions'],
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'design_id': designId,
        'width': width,
        'height': height,
        'cut_positions': cutPositions,
        'updated_at': updatedAt.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'id': id,
      };
}

class PatternPiece {
  final String pieceId;
  final int qty;
  final Outline outline;

  PatternPiece({required this.pieceId, required this.qty, required this.outline});

  factory PatternPiece.fromJson(Map<String, dynamic> json) {
    return PatternPiece(
      pieceId: json['piece_id'] as String,
      qty: json['qty'] as int,
      outline: Outline.fromJson(json['outline'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'piece_id': pieceId,
        'qty': qty,
        'outline': outline.toJson(),
      };
}

class Outline {
  final String format;
  final List<List<num>> points;

  Outline({required this.format, required this.points});

  factory Outline.fromJson(Map<String, dynamic> json) {
    return Outline(
      format: json['format'] as String,
      points: (json['points'] as List<dynamic>)
          .map((row) => (row as List<dynamic>).map((e) => e as num).toList())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'format': format,
        'points': points,
      };
}
