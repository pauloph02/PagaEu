import 'package:paga_eu/components/people.dart';
import 'package:paga_eu/data/database.dart';
import 'package:paga_eu/data/models/pessoa_model.dart';
import 'package:sqflite/sqflite.dart';
import '../components/task.dart';

class PeopleDao{
    static const String tableSql = 'CREATE TABLE $_tablename('
  '$_id TEXT PRIMARY KEY,'
  '$_name TEXT, '
  '$_pago INTEGER, '
  '$_nameService TEXT , '
  ' FOREIGN KEY($_nameService) REFERENCES Servicos(name) )';

static const String _id = 'pessoaId';
static const String _tablename = 'Pessoas';
static const String _name = 'name';
static const String _pago = 'pago';
static const String _nameService = 'nomeServico';

  /* Future create(PessoaEntity pessoa) async {
    try{
      final Database db = await getDatabase();

      pessoa.pessoaId = 
      await db.rawInsert(''' insert into $_tablename(
        $_name, $_pago, $_nameService)
      VALUES(
        '${pessoa.nome}', '${pessoa.pago}', '${pessoa.servico}'
      )

      ''');
    }catch (ex){
      return;
    }
  }  */

  Future<List<PessoaModel>> getAll() async {
    
      final Database db = await getDatabase();

      final List<Map<String, dynamic>> pessoaMap = await db.query(_tablename, orderBy: '${PeopleDao._name} ASC');

      return List.generate(pessoaMap.length, (index) {
        return PessoaModel.fromMap(pessoaMap[index]);
      });


    
  }


  save(People pessoa) async{
    final Database bancoDeDados = await getDatabase();
    var itemExist = await find(pessoa.pessoaID);
    Map<String, dynamic> taskMap = toMap(pessoa);
    if(itemExist.isEmpty){
      return await bancoDeDados.insert(_tablename, taskMap,);
    }else {
      return await bancoDeDados.update(_tablename, taskMap, where: '$_name = ?' , whereArgs: [pessoa.nome]);
    } 
  }
  Map<String,dynamic> toMap(People pessoa){
    final Map<String, dynamic> mapaDePessoas = {};
    mapaDePessoas[_name] = pessoa.nome;
    mapaDePessoas[_pago] = pessoa.pago;
    mapaDePessoas[_nameService] = pessoa.servico;
    mapaDePessoas[_id] = pessoa.pessoaID;
    return mapaDePessoas;
  }

  Future<List<People>>findAll(People pessoa, Task servico)async{
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(_tablename, where: '${pessoa.servico} = ${servico.nome}');
    return toList(result);
  }

  List<People> toList(List<Map<String,dynamic>> mapaDePessoas){
    final List<People> pessoas = [];
    for (Map<String, dynamic> linha in mapaDePessoas){
      final People pessoa =  People(linha[_name],  linha[_pago], linha[_nameService] , linha[_id] );
      pessoas.add(pessoa);
    }
    return pessoas;
  }

  Future <List<People>> find(String pessoa,) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String,dynamic>> result = await bancoDeDados.query(_tablename, 
    where: "$_name = ? AND '$_nameService = Servicos.name'", 
    whereArgs: [pessoa],);
    return toList(result);
  }
  delete(String pessoa)async{
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(_tablename, where: '$_id = ?', whereArgs: [pessoa]);
  }

   Future<List<People>>findAllTeste()async{
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> resultado = await bancoDeDados.rawQuery('SELECT $_tablename.* FROM $_tablename INNER JOIN Servicos ON ($_tablename.$_nameService = Servicos.name)');
    return toList(resultado); 
  }

  update(People pessoa) async{
    final Database bancoDeDados = await getDatabase();
    // ignore: unused_local_variable
    Map<String, dynamic> taskMap = toMap(pessoa);
    return await bancoDeDados.update(_tablename, {_pago : '${pessoa.pago}'}, where: '$_id = ?' , whereArgs: [pessoa.pessoaID]);
  }
  
}
