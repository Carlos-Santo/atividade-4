import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_sobremesa.dart';

const List<ItemCardapio> bebidas = [
  ItemCardapio('Água mineral', 4.50),
  ItemCardapio('Refrigerante lata', 6.90),
  ItemCardapio('Suco natural de laranja', 9.80),
  ItemCardapio('Chá gelado de pêssego', 7.25),
];

/// Tela 2 — recebe o prato escolhido pelo construtor.
class TelaBebida extends StatefulWidget {
  final ItemCardapio prato;

  const TelaBebida({super.key, required this.prato});

  @override
  State<TelaBebida> createState() => _TelaBebidaState();
}

class _TelaBebidaState extends State<TelaBebida> {
  ItemCardapio? bebidaSelecionada;

  void avancar() {
    final bebida = bebidaSelecionada;
    if (bebida == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TelaSobremesa(prato: widget.prato, bebida: bebida),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. Bebida')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Escolha a bebida:'),
          ),
          Expanded(
            child: RadioGroup<ItemCardapio>(
              groupValue: bebidaSelecionada,
              onChanged: (item) => setState(() => bebidaSelecionada = item),
              child: ListView(
                children: [
                  for (final item in bebidas)
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
                  onPressed: bebidaSelecionada == null ? null : avancar,
                  child: const Text('Avançar'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar ao prato principal'),
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
