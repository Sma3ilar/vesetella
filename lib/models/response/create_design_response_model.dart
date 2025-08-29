class CreateDesignResponse {
  final String message;
  final Design design;

  CreateDesignResponse({required this.message, required this.design});

  factory CreateDesignResponse.fromJson(Map<String, dynamic> json) {
    return CreateDesignResponse(
      message: json['message'] as String,
      design: Design.fromJson(json['design'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'design': design.toJson()};
  }
}

class Design {
  final String sleeveType;
  final String collarType;
  final String color;
  final String fabricType;
  final String size;
  final int userId;
  final String generationPrompt;
  final int patternRuleId;
  final String updatedAt;
  final String createdAt;
  final int id;

  Design({
    required this.sleeveType,
    required this.collarType,
    required this.color,
    required this.fabricType,
    required this.size,
    required this.userId,
    required this.generationPrompt,
    required this.patternRuleId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Design.fromJson(Map<String, dynamic> json) {
    return Design(
      sleeveType: json['sleeve_type'] as String,
      collarType: json['collar_type'] as String,
      color: json['color'] as String,
      fabricType: json['fabric_type'] as String,
      size: json['size'] as String,
      userId: json['user_id'] as int,
      generationPrompt: json['generation_prompt'] as String,
      patternRuleId: json['pattern_rule_id'] as int,
      updatedAt: json['updated_at'] as String,
      createdAt: json['created_at'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sleeve_type': sleeveType,
      'collar_type': collarType,
      'color': color,
      'fabric_type': fabricType,
      'size': size,
      'user_id': userId,
      'generation_prompt': generationPrompt,
      'pattern_rule_id': patternRuleId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
