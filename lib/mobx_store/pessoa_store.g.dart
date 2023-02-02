// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PessoaStore on _PessoaStoreBase, Store {
  Computed<String>? _$nomeComputed;

  @override
  String get nome => (_$nomeComputed ??=
          Computed<String>(() => super.nome, name: '_PessoaStoreBase.nome'))
      .value;
  Computed<int>? _$pagoComputed;

  @override
  int get pago => (_$pagoComputed ??=
          Computed<int>(() => super.pago, name: '_PessoaStoreBase.pago'))
      .value;
  Computed<String>? _$servicoComputed;

  @override
  String get servico =>
      (_$servicoComputed ??= Computed<String>(() => super.servico,
              name: '_PessoaStoreBase.servico'))
          .value;

  late final _$_nomeAtom =
      Atom(name: '_PessoaStoreBase._nome', context: context);

  @override
  String? get _nome {
    _$_nomeAtom.reportRead();
    return super._nome;
  }

  @override
  set _nome(String? value) {
    _$_nomeAtom.reportWrite(value, super._nome, () {
      super._nome = value;
    });
  }

  late final _$_pagoAtom =
      Atom(name: '_PessoaStoreBase._pago', context: context);

  @override
  int? get _pago {
    _$_pagoAtom.reportRead();
    return super._pago;
  }

  @override
  set _pago(int? value) {
    _$_pagoAtom.reportWrite(value, super._pago, () {
      super._pago = value;
    });
  }

  late final _$_servicoAtom =
      Atom(name: '_PessoaStoreBase._servico', context: context);

  @override
  String? get _servico {
    _$_servicoAtom.reportRead();
    return super._servico;
  }

  @override
  set _servico(String? value) {
    _$_servicoAtom.reportWrite(value, super._servico, () {
      super._servico = value;
    });
  }

  late final _$_PessoaStoreBaseActionController =
      ActionController(name: '_PessoaStoreBase', context: context);

  @override
  dynamic atualizarNome({required String nome}) {
    final _$actionInfo = _$_PessoaStoreBaseActionController.startAction(
        name: '_PessoaStoreBase.atualizarNome');
    try {
      return super.atualizarNome(nome: nome);
    } finally {
      _$_PessoaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic atualizarPago({required String pago}) {
    final _$actionInfo = _$_PessoaStoreBaseActionController.startAction(
        name: '_PessoaStoreBase.atualizarPago');
    try {
      return super.atualizarPago(pago: pago);
    } finally {
      _$_PessoaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic atualizarServico({required String servico}) {
    final _$actionInfo = _$_PessoaStoreBaseActionController.startAction(
        name: '_PessoaStoreBase.atualizarServico');
    try {
      return super.atualizarServico(servico: servico);
    } finally {
      _$_PessoaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nome: ${nome},
pago: ${pago},
servico: ${servico}
    ''';
  }
}
