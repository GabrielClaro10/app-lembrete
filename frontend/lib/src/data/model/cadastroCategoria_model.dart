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
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['nome'] = nome;
    data['status'] = status;
    data['user_id'] = userId;
    return data;
  }
}
