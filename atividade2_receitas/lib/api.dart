import 'dart:convert';
import 'package:http/http.dart' as http;
import 'receita.dart';

// Sem termo busca todas as receitas; com termo usa a pesquisa remota
Future<List<Receita>> buscarReceitas({String? termo}) async {
  final Uri url;
  if (termo == null) {
    url = Uri.https('dummyjson.com', '/recipes', {'limit': '0'});
  } else {
    url = Uri.https('dummyjson.com', '/recipes/search', {'q': termo});
  }

  final resposta = await http.get(url).timeout(const Duration(seconds: 10));

  // Confere o status antes de usar a resposta
  if (resposta.statusCode != 200) {
    throw Exception('Erro do servidor: ${resposta.statusCode}');
  }

  // Valida o JSON antes de atualizar a tela
  final dados = jsonDecode(resposta.body);
  if (dados is! Map || dados['recipes'] is! List) {
    throw Exception('Resposta fora do formato esperado');
  }

  return (dados['recipes'] as List)
      .map((item) => Receita.fromJson(item as Map<String, dynamic>))
      .toList();
}