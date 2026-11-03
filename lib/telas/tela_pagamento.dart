import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import 'tela_finalizacao.dart';

const List<String> formasPagamento = [
  'Pix',
  'Cartão de crédito',
  'Cartão de débito',
  'Dinheiro',
];

/// Tela 4 — recebe prato, bebida e sobremesa pelo construtor.
class TelaPagamento extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;

  const TelaPagamento({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
  });

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();
}

class _TelaPagamentoState extends State<TelaPagamento> {
  String? pagamentoSelecionado;

  void finalizar() {
    final pagamento = pagamentoSelecionado;
    if (pagamento == null) return;

    // Remove todas as rotas anteriores: na finalização não é possível
    // voltar às etapas do pedido.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => TelaFinalizacao(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: widget.sobremesa,
          formaPagamento: pagamento,
        ),
      ),
      (rota) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4. Forma de pagamento')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Escolha a forma de pagamento:'),
          ),
          Expanded(
            child: RadioGroup<String>(
              groupValue: pagamentoSelecionado,
              onChanged: (forma) =>
                  setState(() => pagamentoSelecionado = forma),
              child: ListView(
                children: [
                  for (final forma in formasPagamento)
                    RadioListTile<String>(value: forma, title: Text(forma)),
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
                  onPressed: pagamentoSelecionado == null ? null : finalizar,
                  child: const Text('Finalizar pedido'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar à sobremesa'),
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
