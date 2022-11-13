class Products {
  int? id;
  String? descricao;
  double? valor;
  String? marca;

  Products({this.id, this.descricao, this.valor, this.marca});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    valor = double.parse(json['valor']);
    marca = json['marca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    data['valor'] = valor;
    data['marca'] = marca;
    return data;
  }
}
