class CadastroCompromissos {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? local;
  String? data;
  String? descricao;
  String? notificacao;
  String? status;
  String? obs;
  int? idUsers;
  int? idCategoria;

  CadastroCompromissos({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.local,
    this.data,
    this.descricao,
    this.notificacao,
    this.status,
    this.obs,
    this.idUsers,
    this.idCategoria,
  });

  CadastroCompromissos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    local = json['local'];
    data = json['data'];
    notificacao = json['notificacao'];
    status = json['status'];
    obs = json['obs'];
    descricao = json['descricao'];
    idUsers = json['id_users'] != null
        ? int.tryParse(json['id_users'].toString())
        : null;
    idCategoria = json['id_categoria'] != null
        ? int.tryParse(json['id_categoria'].toString())
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['local'] = local;
    data['notificacao'] = notificacao;
    data['status'] = status;
    data['obs'] = obs;
    data['descricao'] = descricao;
    data['id_users'] = idUsers;
    data['id_categoria'] = idCategoria;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CadastroCompromissos &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
