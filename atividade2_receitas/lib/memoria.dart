import 'receita.dart';

// Receitas já carregadas, para não buscar de novo ao trocar de aba
List<Receita> receitasCarregadas = [];

// Favoritos da sessão: a chave é o id, então nunca duplica
final Map<int, Receita> favoritos = {};

bool ehFavorita(int id) => favoritos.containsKey(id);

void alternarFavorito(Receita receita) {
  if (ehFavorita(receita.id)) {
    favoritos.remove(receita.id);
  } else {
    favoritos[receita.id] = receita;
  }
}