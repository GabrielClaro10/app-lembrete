class User {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? nome;
  String? dataNascimento;
  String? email;
  Null tema;
  Null foto;
  String? telefone;

  User(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.nome,
      this.dataNascimento,
      this.email,
      this.tema,
      this.foto,
      this.telefone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nome = json['nome'];
    dataNascimento = json['data_nascimento'];
    email = json['email'];
    tema = json['tema'];
    foto = json['foto'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nome'] = this.nome;
    data['data_nascimento'] = this.dataNascimento;
    data['email'] = this.email;
    data['tema'] = this.tema;
    data['foto'] = this.foto;
    data['telefone'] = this.telefone;
    return data;
  }
}
