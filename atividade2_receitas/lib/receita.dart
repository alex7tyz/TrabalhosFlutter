class Receita {
  final int id;
  final String nome;
  final String? imagem;
  final String? dificuldade;
  final List<String> ingredientes;
  final List<String> passos;
  final List<String> tipos;
  final num? preparo;
  final num? cozimento;
  final num? porcoes;
  final num? nota;

  const Receita({
    required this.id,
    required this.nome,
    required this.imagem,
    required this.dificuldade,
    required this.ingredientes,
    required this.passos,
    required this.tipos,
    required this.preparo,
    required this.cozimento,
    required this.porcoes,
    required this.nota,
  });

  // Converte o JSON da API em uma Receita, tratando campos ausentes
  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita(
      id: json['id'] as int,
      nome: (json['name'] ?? 'Receita sem nome').toString(),
      imagem: json['image'] as String?,
      dificuldade: json['difficulty'] as String?,
      ingredientes: _lista(json['ingredients']),
      passos: _lista(json['instructions']),
      tipos: _lista(json['mealType']),
      preparo: json['prepTimeMinutes'] as num?,
      cozimento: json['cookTimeMinutes'] as num?,
      porcoes: json['servings'] as num?,
      nota: json['rating'] as num?,
    );
  }

  // Soma só os tempos que vieram; se nenhum veio, avisa em vez de mostrar 0
  String get tempoTexto {
    if (preparo == null && cozimento == null) return 'não informado';
    return '${((preparo ?? 0) + (cozimento ?? 0)).round()} min';
  }

  String get notaTexto {
    final n = nota;
    if (n == null) return 'Sem avaliação';
    return '${n.toStringAsFixed(1).replaceAll('.', ',')} / 5';
  }

  String get tiposTexto => tipos.isEmpty ? 'Receita' : tipos.join(', ');

  // Só mostra as porções se o valor for utilizável
  String? get porcoesTexto {
    final p = porcoes;
    if (p == null || p <= 0) return null;
    return p.round().toString();
  }
}

// Garante uma lista de textos, mesmo se o campo vier ausente ou diferente
List<String> _lista(dynamic valor) {
  if (valor is String) return [valor];
  if (valor is List) return valor.map((item) => item.toString()).toList();
  return [];
}