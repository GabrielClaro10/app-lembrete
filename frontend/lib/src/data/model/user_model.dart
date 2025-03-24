class User {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? nome;
  String? dataNascimento;
  String? email;
  String? foto;
  String? telefone;

  User(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.nome,
      this.dataNascimento,
      this.email,
      this.foto,
      this.telefone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nome = json['nome'];
    dataNascimento = json['data_nascimento'];
    email = json['email'];
    foto = json['foto'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['nome'] = nome;
    data['data_nascimento'] = dataNascimento;
    data['email'] = email;
    data['foto'] = foto;
    data['telefone'] = telefone;
    return data;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, nome: $nome, email: $email, foto: $foto, telefone: $telefone, dataNascimento: $dataNascimento)';
  }
}
