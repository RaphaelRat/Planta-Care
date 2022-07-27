class Planta {
  String temperaturaAmb;
  String umidadeSolo;
  bool regarPlanta;
  bool regando;
  bool possuiRegaAutomatica;
  bool regaAutomatica;
  int regaAutomaticaTempo;
  int ultimaRega;
  String nome;
  String especie;
  String umidadeAmb;

  Planta({
    required this.temperaturaAmb,
    required this.umidadeSolo,
    required this.umidadeAmb,
    required this.regarPlanta,
    required this.regando,
    required this.possuiRegaAutomatica,
    required this.regaAutomatica,
    required this.regaAutomaticaTempo,
    required this.ultimaRega,
    required this.nome,
    required this.especie,
  });

  Planta copyWith({
    String? temperaturaAmb,
    String? umidadeSolo,
    String? umidadeAmb,
    bool? regarPlanta,
    bool? regando,
    bool? possuiRegaAutomatica,
    bool? regaAutomatica,
    int? regaAutomaticaTempo,
    int? ultimaRega,
    String? nome,
    String? especie,
  }) {
    return Planta(
      temperaturaAmb: temperaturaAmb ?? this.temperaturaAmb,
      umidadeSolo: umidadeSolo ?? this.umidadeSolo,
      umidadeAmb: umidadeAmb ?? this.umidadeAmb,
      regarPlanta: regarPlanta ?? this.regarPlanta,
      regando: regando ?? this.regando,
      possuiRegaAutomatica: possuiRegaAutomatica ?? this.possuiRegaAutomatica,
      regaAutomatica: regaAutomatica ?? this.regaAutomatica,
      regaAutomaticaTempo: regaAutomaticaTempo ?? this.regaAutomaticaTempo,
      ultimaRega: ultimaRega ?? this.ultimaRega,
      nome: nome ?? this.nome,
      especie: especie ?? this.especie,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temperaturaAmb': temperaturaAmb,
      'umidadeSolo': umidadeSolo,
      'umidadeAmb': umidadeAmb,
      'regarPlanta': regarPlanta,
      'regando': regando,
      'possuiRegaAutomatica': possuiRegaAutomatica,
      'regaAutomatica': regaAutomatica,
      'regaAutomaticaTempo': regaAutomaticaTempo,
      'ultimaRega': ultimaRega,
      'nome': nome,
      'especie': especie,
    };
  }

  factory Planta.fromMap(Map<dynamic, dynamic> map) {
    return Planta(
      temperaturaAmb: map['temperaturaAmb']?.toString() ?? '',
      umidadeSolo: map['umidadeSolo']?.toString() ?? '',
      umidadeAmb: map['umidadeAmb']?.toString() ?? '',
      regarPlanta: map['regarPlanta'] ?? false,
      regando: map['regando'] ?? false,
      possuiRegaAutomatica: map['possuiRegaAutomatica'] ?? false,
      regaAutomatica: map['regaAutomatica'] ?? false,
      regaAutomaticaTempo: map['regaAutomaticaTempo']?.toInt() ?? 0,
      ultimaRega: map['ultimaRega'] ?? DateTime.now().millisecondsSinceEpoch,
      nome: map['nome']?.toString() ?? '',
      especie: map['especie']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'Planta(temperaturaAmb: $temperaturaAmb, umidadeSolo: $umidadeSolo, regarPlanta: $regarPlanta, regando: $regando, possuiRegaAutomatica: $possuiRegaAutomatica, regaAutomatica: $regaAutomatica, regaAutomaticaTempo: $regaAutomaticaTempo, ultimaRega: $ultimaRega, nome: $nome, especie: $especie)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Planta &&
        other.temperaturaAmb == temperaturaAmb &&
        other.umidadeSolo == umidadeSolo &&
        other.regarPlanta == regarPlanta &&
        other.regando == regando &&
        other.possuiRegaAutomatica == possuiRegaAutomatica &&
        other.regaAutomatica == regaAutomatica &&
        other.regaAutomaticaTempo == regaAutomaticaTempo &&
        other.ultimaRega == ultimaRega &&
        other.nome == nome &&
        other.especie == especie;
  }

  @override
  int get hashCode {
    return temperaturaAmb.hashCode ^
        umidadeSolo.hashCode ^
        regarPlanta.hashCode ^
        regando.hashCode ^
        possuiRegaAutomatica.hashCode ^
        regaAutomatica.hashCode ^
        regaAutomaticaTempo.hashCode ^
        ultimaRega.hashCode ^
        nome.hashCode ^
        especie.hashCode;
  }
}
