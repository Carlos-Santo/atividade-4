import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_pagamento.dart';

const List<ItemCardapio> sobremesas = [
  ItemCardapio('Pudim de leite', 12.00),
  ItemCardapio('Mousse de maracujá', 10.50),
  ItemCardapio('Petit gâteau com sorvete', 18.90),
  ItemCardapio('Salada de frutas', 8.75),
];

/// Tela 3 — recebe o prato e a bebida pelo construtor.
class TelaSobremesa extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;

  const TelaSobremesa({super.key, required this.prato, required this.bebida});

  @override
  State<TelaSobremesa> createState() => _TelaSobremesaState();
}

class _TelaSobremesaState extends State<TelaSobremesa> {
  ItemCardapio? sobremesaSelecionada;

  void avancar() {
    final sobremesa = sobremesaSelecionada;
    if (sobremesa == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPagamento(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: sobremesa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3. Sobremesa')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Escolha a sobremesa:'),
          ),
          Expanded(
            child: RadioGroup<ItemCardapio>(
              groupValue: sobremesaSelecionada,
              onChanged: (item) => setState(() => sobremesaSelecionada = item),
              child: ListView(
                children: [
                  for (final item in sobremesas)
                    RadioListTile<ItemCardapio>(
                      value: item,
                      title: Text(item.nome),
                      subtitle: Text(formatarValor(item.valor)),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: sobremesaSelecionada == null ? null : avancar,
                  child: const Text('Avançar'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar à bebida'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.popUntil(context, (rota) => rota.isFirst),
                  child: const Text('Voltar ao início'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
