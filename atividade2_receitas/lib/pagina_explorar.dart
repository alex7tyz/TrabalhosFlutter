import 'package:flutter/material.dart';

import 'dados.dart';
import 'pagina_pesquisa.dart';
import 'tema.dart';
import 'widgets.dart';

class PaginaExplorar extends StatefulWidget {
  const PaginaExplorar({super.key});

  @override
  State<PaginaExplorar> createState() => _PaginaExplorarState();
}

class _PaginaExplorarState extends State<PaginaExplorar> {
  String estado = 'carregando'; // carregando, erro ou lista

  @override
  void initState() {
    super.initState();
    if (receitasCarregadas) {
      estado = 'lista';
    } else {
      carregar();
    }
  }

  // Simula a espera da API (2 segundos)
  Future<void> carregar() async {
    setState(() => estado = 'carregando');
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      estado = simularErro ? 'erro' : 'lista';
      receitasCarregadas = !simularErro;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Colher de Pau')),
      body: corpo(),
    );
  }

  Widget corpo() {
    if (estado == 'carregando') {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Carregando receitas…'),
          ],
        ),
      );
    }

    if (estado == 'erro') {
      return TelaMensagem(
        icone: Icons.error_outline,
        titulo: 'Não foi possível carregar as receitas.',
        texto: 'Verifique sua conexão e tente novamente.',
        botoes: [
          ElevatedButton(
            onPressed: carregar,
            child: const Text('Tentar novamente'),
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'O que vai pra panela hoje?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Pesquise uma receita pelo nome.'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaginaPesquisa()),
            ).then((_) => setState(() {}));
          },
          child: const Text('Pesquisar receita'),
        ),
        const SizedBox(height: 24),
        const Text('Receitas disponíveis', style: estiloTitulo),
        const Text('Selecione uma receita para ver o preparo.'),
        for (final r in receitas)
          CardReceita(receita: r, aoAtualizar: () => setState(() {})),
      ],
    );
  }
}
