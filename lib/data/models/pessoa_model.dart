// ignore_for_file: must_be_immutable

import 'package:paga_eu/data/domain/entity/pessoa_entity.dart';

class PessoaModel extends PessoaEntity {
  PessoaModel({
    pessoaId, 
    required nome, 
    required pago,
    required servico,
  }) :super(pessoaId: pessoaId, nome: nome, pago: pago, servico: servico);


  
  factory PessoaModel.fromMap(Map<String, Object?> map){
    
    return PessoaModel(
      pessoaId: (map["pessoaId"]  as num).toInt()
    ,nome: map["name"]
    , pago: (map["pago"] as num).toInt()
    , servico: map["nomeServico"]);
  }

}



