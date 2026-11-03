# Pedidos do Restaurante — Aula 4

Programação para Dispositivos Móveis I — Prof. Arley — Fatec

## Integrantes

- Carlos Santo

## Sobre

Aplicativo Flutter (Android) para montar um pedido de restaurante em cinco telas,
praticando navegação com `Navigator` e `MaterialPageRoute` e envio de dados pelos
construtores das telas.

1. **Prato principal**: quatro opções com preço.
2. **Bebida**: quatro opções com preço.
3. **Sobremesa**: quatro opções com preço.
4. **Forma de pagamento**: Pix, cartão de crédito, cartão de débito ou dinheiro.
5. **Finalização**: itens escolhidos, preço de cada um, total e forma de pagamento.

Regras atendidas:

- O botão **Avançar** só fica habilitado depois de escolher uma opção.
- Nas telas 2, 3 e 4 é possível voltar à tela anterior (`Navigator.pop`) ou direto ao
  início (`Navigator.popUntil(... rota.isFirst)`).
- Ao voltar, a escolha da tela anterior continua marcada, porque o `State` dela segue
  na pilha.
- A finalização é aberta com `pushAndRemoveUntil`, então não há como voltar às etapas.
  O botão "voltar" do sistema também fica bloqueado (`PopScope`). **Novo pedido** abre
  uma tela inicial nova, com as escolhas zeradas.
- Valores em reais com duas casas decimais (`formatarValor`).

## Baixar o APK

O APK é gerado automaticamente pelo GitHub Actions a cada push, então não é preciso
ter o Android SDK instalado para testar o app.

1. Abra a aba [Actions](https://github.com/Carlos-Santo/atividade-4/actions/workflows/build-apk.yml)
   e clique na execução mais recente com ✅.
2. No fim da página, em **Artifacts**, baixe **pedidos-restaurante-apk** (é preciso estar logado no GitHub).
3. Extraia o `.zip` e instale o `app-release.apk` no celular Android, permitindo a
   instalação de fontes desconhecidas.

Se o artefato tiver expirado (ficam disponíveis por 90 dias), use **Run workflow** na
mesma página para gerar um novo.

## Como executar

```bash
flutter pub get
flutter run            # Android
flutter run -d chrome  # também roda no navegador
flutter test           # testa o fluxo completo do pedido
```

## Estrutura

```
lib/
├── main.dart
├── models/
│   └── item_cardapio.dart
├── utils/
│   └── formatar_valor.dart
└── telas/
    ├── tela_prato_principal.dart
    ├── tela_bebida.dart
    ├── tela_sobremesa.dart
    ├── tela_pagamento.dart
    └── tela_finalizacao.dart
```
