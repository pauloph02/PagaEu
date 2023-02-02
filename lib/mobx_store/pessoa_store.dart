import 'package:mobx/mobx.dart';
part 'pessoa_store.g.dart';


/// flutter packages pub run build_runner build
 
class PessoaStore = _PessoaStoreBase with _$PessoaStore;

abstract class _PessoaStoreBase with Store {
  @observable
  String? _nome;

  @computed 
  String get nome => _nome ?? '';

   @action
  atualizarNome({required String nome}){
    _nome = nome;
  }

  @observable
  int? _pago;

   @computed 
  int get pago => _pago ?? 0;

   @action
  atualizarPago({required String pago}){
    _pago = int.parse(pago);
  }


  @observable
  String? _servico;

  @computed 
  String get servico => _servico ?? ''; 

  @action
  atualizarServico({required String servico}){
    _servico = servico;
  }

  @computed 
  bool get dadosPreenchidos => nome.isNotEmpty;
}