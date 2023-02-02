// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class PessoaEntity extends Equatable {
  late int? pessoaId;
  final String nome;
   int pago = 0;
   final String servico;

   PessoaEntity({this.pessoaId, required this.nome, required this.pago, required this.servico});




  @override
  List<Object?> get props => [pessoaId];
  
  }