class Statistic {
  final int quantidade;
  final String rotulo;
  final String sufixo;

  const Statistic({
    required this.quantidade,
    required this.rotulo,
    this.sufixo = '+',
  });

  String get quantidadeFormatada {
    if (quantidade >= 1000) {
      final valor = quantidade / 1000;
      return '${valor.toStringAsFixed(valor.truncateToDouble() == valor ? 0 : 1)}k$sufixo';
    }
    return '$quantidade$sufixo';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Statistic &&
        other.quantidade == quantidade &&
        other.rotulo == rotulo &&
        other.sufixo == sufixo;
  }

  @override
  int get hashCode {
    return quantidade.hashCode ^ rotulo.hashCode ^ sufixo.hashCode;
  }

  @override
  String toString() {
    return 'Statistic(quantidade: $quantidade, rotulo: $rotulo, sufixo: $sufixo)';
  }
}
