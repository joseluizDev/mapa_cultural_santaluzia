class Rating {
  final String userId;
  final String userName;
  final double rating;
  final String? comment;
  final DateTime date;

  const Rating({
    required this.userId,
    required this.userName,
    required this.rating,
    this.comment,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userId: json['userId'],
      userName: json['userName'],
      rating: json['rating'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }
}

class Talent {
  final String nome;
  final String cidade;
  final String estado;
  final String descricao;
  final String imagemUrl;
  final List<String> habilidades;
  final String? instagram;
  final String? whatsapp;
  final double rating;
  final int totalRatings;
  final List<Rating> ratings;

  const Talent({
    required this.nome,
    required this.cidade,
    required this.estado,
    required this.descricao,
    required this.imagemUrl,
    required this.habilidades,
    this.instagram,
    this.whatsapp,
    this.rating = 0.0,
    this.totalRatings = 0,
    this.ratings = const [],
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
    String? instagram,
    String? whatsapp,
    double? rating,
    int? totalRatings,
    List<Rating>? ratings,
  }) {
    return Talent(
      nome: nome ?? this.nome,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      descricao: descricao ?? this.descricao,
      imagemUrl: imagemUrl ?? this.imagemUrl,
      habilidades: habilidades ?? this.habilidades,
      instagram: instagram ?? this.instagram,
      whatsapp: whatsapp ?? this.whatsapp,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      ratings: ratings ?? this.ratings,
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
    return 'Talent(nome: $nome, cidade: $cidade, estado: $estado, descricao: $descricao, habilidades: $habilidades, instagram: $instagram, whatsapp: $whatsapp, rating: $rating, totalRatings: $totalRatings, ratings: $ratings)';
  }
}
