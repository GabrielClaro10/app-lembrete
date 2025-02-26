class CadastroCategoria {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? nome;
  String? status;
  int? userId;

  CadastroCategoria({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nome,
    this.status,
    this.userId,
  });

  CadastroCategoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nome = json['nome'];
    status = json['status'];
    userId = json['user_id'] != null ? json['user_id'] as int : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['nome'] = nome;
    data['status'] = status;
    data['user_id'] = userId;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CadastroCategoria &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
