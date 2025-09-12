class Talent {
  final String nome;
  final String cidade;
  final String estado;
  final String descricao;
  final String imagemUrl;
  final List<String> habilidades;

  const Talent({
    required this.nome,
    required this.cidade,
    required this.estado,
    required this.descricao,
    required this.imagemUrl,
    required this.habilidades,
  });

  String get localizacaoCompleta => '$cidade, $estado';

  // Método para criar uma cópia com modificações
  Talent copyWith({
    String? nome,
    String? cidade,
    String? estado,
    String? descricao,
    String? imagemUrl,
    List<String>? habilidades,
  }) {
    return Talent(
      nome: nome ?? this.nome,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      descricao: descricao ?? this.descricao,
      imagemUrl: imagemUrl ?? this.imagemUrl,
      habilidades: habilidades ?? this.habilidades,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Talent &&
        other.nome == nome &&
        other.cidade == cidade &&
        other.estado == estado &&
        other.descricao == descricao &&
        other.imagemUrl == imagemUrl;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        cidade.hashCode ^
        estado.hashCode ^
        descricao.hashCode ^
        imagemUrl.hashCode;
  }

  @override
  String toString() {
    return 'Talent(nome: $nome, cidade: $cidade, estado: $estado, descricao: $descricao, habilidades: $habilidades)';
  }
}
