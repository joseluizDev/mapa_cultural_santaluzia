class Advertisement {
  final String nome;
  final String imagemUrl;
  final DateTime dataInicio;
  final DateTime dataFim;
  final bool ativa;

  const Advertisement({
    required this.nome,
    required this.imagemUrl,
    required this.dataInicio,
    required this.dataFim,
    required this.ativa,
  });

  String get periodo {
    final inicio = '${dataInicio.day}/${dataInicio.month}/${dataInicio.year}';
    final fim = '${dataFim.day}/${dataFim.month}/${dataFim.year}';
    return '$inicio - $fim';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Advertisement &&
        other.nome == nome &&
        other.imagemUrl == imagemUrl &&
        other.dataInicio == dataInicio &&
        other.dataFim == dataFim &&
        other.ativa == ativa;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        imagemUrl.hashCode ^
        dataInicio.hashCode ^
        dataFim.hashCode ^
        ativa.hashCode;
  }

  @override
  String toString() {
    return 'Advertisement(nome: $nome, imagemUrl: $imagemUrl, dataInicio: $dataInicio, dataFim: $dataFim, ativa: $ativa)';
  }
}
