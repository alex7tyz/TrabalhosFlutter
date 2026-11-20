class Receita {
  final int id;
  final String nome;
  final String categoria;
  final String dificuldade;
  final int tempo;
  final int porcoes;
  final double nota;
  final List<String> ingredientes;
  final List<String> passos;

  const Receita({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.dificuldade,
    required this.tempo,
    required this.porcoes,
    required this.nota,
    required this.ingredientes,
    required this.passos,
  });

  // Mostra a nota com vírgula (4,8)
  String get notaTexto => nota.toString().replaceAll('.', ',');
}

// Dados provisórios, depois vão vir da API
const List<Receita> receitas = [
  Receita(
    id: 1,
    nome: 'Pão de Queijo Mineiro',
    categoria: 'Lanche',
    dificuldade: 'Fácil',
    tempo: 40,
    porcoes: 6,
    nota: 4.8,
    ingredientes: ['Polvilho azedo', 'Queijo minas', 'Leite', 'Óleo', 'Ovos'],
    passos: [
      'Preaqueça o forno a 200 °C.',
      'Escalde o polvilho com o leite e o óleo quentes.',
      'Misture os ovos e o queijo e modele as bolinhas.',
      'Asse por 25 minutos, até dourar.',
    ],
  ),
  Receita(
    id: 2,
    nome: 'Feijoada Completa',
    categoria: 'Almoço',
    dificuldade: 'Média',
    tempo: 180,
    porcoes: 8,
    nota: 4.7,
    ingredientes: ['Feijão preto', 'Carne seca', 'Linguiça', 'Bacon', 'Alho'],
    passos: [
      'Deixe o feijão e as carnes de molho na véspera.',
      'Cozinhe tudo na panela de pressão por 40 minutos.',
      'Refogue o alho, junte ao feijão e deixe apurar.',
    ],
  ),
  Receita(
    id: 3,
    nome: 'Brigadeiro de Panela',
    categoria: 'Sobremesa',
    dificuldade: 'Fácil',
    tempo: 20,
    porcoes: 10,
    nota: 4.9,
    ingredientes: ['Leite condensado', 'Chocolate em pó', 'Manteiga'],
    passos: [
      'Misture tudo em uma panela.',
      'Mexa em fogo baixo até desgrudar do fundo.',
      'Deixe esfriar e sirva com granulado.',
    ],
  ),
];

// Única fonte de verdade dos favoritos: só os ids, então não duplica
final Set<int> favoritos = {};

void alternarFavorito(int id) {
  if (favoritos.contains(id)) {
    favoritos.remove(id);
  } else {
    favoritos.add(id);
  }
}

// Controles da simulação de carregamento (provisório)
bool receitasCarregadas = false;
bool simularErro = false; // mude para true para ver a tela de erro
