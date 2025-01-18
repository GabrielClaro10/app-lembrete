class CadastroCategoria {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? nome;
  String? status;

  CadastroCategoria({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nome,
    this.status,
  });

  CadastroCategoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nome = json['nome'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nome'] = this.nome;
    data['status'] = this.status;
    return data;
  }
}
