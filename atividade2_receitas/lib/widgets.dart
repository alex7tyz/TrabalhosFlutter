import 'package:flutter/material.dart';
import 'imagem_receita.dart';
import 'memoria.dart';
import 'pagina_detalhes.dart';
import 'receita.dart';
import 'tema.dart';

// Card de uma receita (usado no início, na pesquisa e nos favoritos)
class CardReceita extends StatelessWidget {
  final Receita receita;
  final VoidCallback aoAtualizar;

  const CardReceita({
    super.key,
    required this.receita,
    required this.aoAtualizar,
  });

  @override
  Widget build(BuildContext context) {
    final salva = ehFavorita(receita.id);

    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ImagemReceita(url: receita.imagem, largura: 64, altura: 64),
        ),
        title: Text(receita.nome, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${receita.tiposTexto}\n'
              'Tempo ${receita.tempoTexto} • ${receita.notaTexto}',
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(
            salva ? Icons.favorite : Icons.favorite_border,
            color: terracota,
          ),
          onPressed: () {
            alternarFavorito(receita);
            aoAtualizar();
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaginaDetalhes(receita: receita),
            ),
          ).then((_) => aoAtualizar());
        },
      ),
    );
  }
}