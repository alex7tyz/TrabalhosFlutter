import 'package:flutter/material.dart';
import 'memoria.dart';
import 'tema.dart';
import 'telas_estado.dart';
import 'widgets.dart';

class PaginaFavoritos extends StatefulWidget {
  final VoidCallback aoExplorar;

  const PaginaFavoritos({super.key, required this.aoExplorar});

  @override
  State<PaginaFavoritos> createState() => _PaginaFavoritosState();
}

class _PaginaFavoritosState extends State<PaginaFavoritos> {
  @override
  Widget build(BuildContext context) {
    final salvas = favoritos.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Colher de Pau')),
      body: salvas.isEmpty
          ? TelaMensagem(
        icone: Icons.favorite_border,
        titulo: 'Nenhum favorito',
        texto: 'Marque uma receita como favorita para encontrá-la aqui.',
        botoes: [
          ElevatedButton(
            onPressed: widget.aoExplorar,
            child: const Text('Explorar receitas'),
          ),
        ],
      )
          : ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Favoritos', style: estiloTitulo),
          const Text('Receitas salvas nesta sessão.'),
          const Text('Toque no coração para remover.'),
          for (final r in salvas)
            CardReceita(receita: r, aoAtualizar: () => setState(() {})),
        ],
      ),
    );
  }
}