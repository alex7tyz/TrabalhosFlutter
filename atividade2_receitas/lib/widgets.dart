  import 'package:flutter/material.dart';
  import 'dados.dart';
  import 'pagina_detalhes.dart';
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
      final salva = favoritos.contains(receita.id);

      return Card(
        child: ListTile(
          leading: const Icon(Icons.restaurant, color: oliva),
          title: Text(receita.nome),
          subtitle: Text(
            '${receita.categoria} • ${receita.tempo} min • ${receita.dificuldade}\n'
                '${receita.notaTexto} / 5',
          ),
          isThreeLine: true,
          trailing: IconButton(
            icon: Icon(
              salva ? Icons.favorite : Icons.favorite_border,
              color: terracota,
            ),
            onPressed: () {
              alternarFavorito(receita.id);
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

  // Tela com ícone, título, texto e botões (erro, sem resultado, sem favoritos)
  class TelaMensagem extends StatelessWidget {
    final IconData icone;
    final String titulo;
    final String texto;
    final List<Widget> botoes;

    const TelaMensagem({
      super.key,
      required this.icone,
      required this.titulo,
      required this.texto,
      required this.botoes,
    });

    @override
    Widget build(BuildContext context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icone, size: 64, color: terracota),
              const SizedBox(height: 12),
              Text(titulo, textAlign: TextAlign.center, style: estiloTitulo),
              const SizedBox(height: 8),
              Text(texto, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ...botoes,
            ],
          ),
        ),
      );
    }
  }