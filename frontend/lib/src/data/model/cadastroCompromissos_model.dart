class CadastroCompromissos {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? tipoCompromisso;
  String? local;
  String? data;
  bool? repetirAlarme;
  String? descricao;
  String? notificacao;
  String? status;
  String? obs;

  CadastroCompromissos({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.tipoCompromisso,
    this.local,
    this.data,
    this.repetirAlarme,
    this.descricao,
    this.notificacao,
    this.status,
    this.obs,
  });

  factory CadastroCompromissos.fromJson(Map<String, dynamic> json) {
    return CadastroCompromissos(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      tipoCompromisso: json['tipoCompromisso'],
      local: json['local'],
      data: json['data'],
      repetirAlarme: json['repetirAlarme'],
      descricao: json['descricao'],
      notificacao: json['notificacao'],
      status: json['status'],
      obs: json['obs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'tipoCompromisso': tipoCompromisso,
      'local': local,
      'data': data,
      'repetirAlarme': repetirAlarme,
      'descricao': descricao,
      'notificacao': notificacao,
      'status': status,
      'obs': obs,
    };
  }

  @override
  String toString() {
    return 'CadastroCompromissos{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, tipoCompromisso: $tipoCompromisso, local: $local, data: $data, repetirAlarme: $repetirAlarme, descricao: $descricao, notificacao: $notificacao, status: $status, obs: $obs}';
  }
}
