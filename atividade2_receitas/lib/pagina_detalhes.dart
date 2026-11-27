
import 'package:flutter/material.dart';
import 'memoria.dart';
import 'receita.dart';
import 'tema.dart';

class PaginaDetalhes extends StatefulWidget {
  final Receita receita;

  const PaginaDetalhes({super.key, required this.receita});

  @override
  State<PaginaDetalhes> createState() => _PaginaDetalhesState();
}

class _PaginaDetalhesState extends State<PaginaDetalhes> {
  @override
  Widget build(BuildContext context) {
    final r = widget.receita;
    final salva = ehFavorita(r.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receita'),
        actions: [
          IconButton(
            icon: Icon(
              salva ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () {
              setState(() {
                alternarFavorito(r);
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 200,
            color: Colors.grey.shade300,
            child: r.imagem != null
                ? Image.network(
              r.imagem!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.restaurant,
                  size: 60,
                );
              },
            )
                : const Icon(Icons.restaurant, size: 60),
          ),

          const SizedBox(height: 16),

          Text(
            r.nome,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            '${r.tiposTexto} • ${r.dificuldade ?? 'Não informada'} • ${r.notaTexto}',
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${r.tempoTexto}\ntempo total',
                textAlign: TextAlign.center,
              ),
              Text(
                '${r.porcoesTexto ?? 'Não informado'}\nporções',
                textAlign: TextAlign.center,
              ),
              Text(
                salva
                    ? 'Salva\nnos favoritos'
                    : 'Não salva\nnos favoritos',
                textAlign: TextAlign.center,
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text('Ingredientes', style: estiloTitulo),

          for (final item in r.ingredientes)
            Text(
              '• $item',
              style: const TextStyle(height: 1.6),
            ),

          const SizedBox(height: 20),

          const Text('Modo de preparo', style: estiloTitulo),

          for (int i = 0; i < r.passos.length; i++)
            Text(
              '${i + 1}. ${r.passos[i]}',
              style: const TextStyle(height: 1.6),
            ),
        ],
      ),
    );
  }
}
