import 'package:paga_eu/components/task.dart';
import 'package:paga_eu/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao{
    static const String tableSql = 'CREATE TABLE $_tablename('
  '$_name TEXT PRIMARY KEY, '
  '$_numeroPessoas TEXT, '
  '$_color TEXT, '
  '$_dataVencimento TEXT, '
  '$_numeroPessoasPago TEXT)';

static const String _tablename = 'Servicos';
static const String _name = 'name';
static const String _numeroPessoas = 'numeroPessoas';
static const String _color = 'color';
static const String _dataVencimento = 'dataVencimento';
static const String _numeroPessoasPago = 'pessoasPago';

  save(Task tarefa) async{
    final Database bancoDeDados = await getDatabase();
    var itemExist = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if(itemExist.isEmpty){
      return await bancoDeDados.insert(_tablename, taskMap);
    }else {
      return await bancoDeDados.update(_tablename, taskMap, where: '$_name = ?' , whereArgs: [tarefa.nome]);
    }
  }
  Map<String,dynamic> toMap(Task tarefa){
    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_numeroPessoas] = tarefa.numeroPessoas;
    mapaDeTarefas[_color] = tarefa.cor;
    mapaDeTarefas[_dataVencimento] = tarefa.dataVencimento;
    mapaDeTarefas[_numeroPessoasPago] = tarefa.numeroPessoasPago;
    return mapaDeTarefas;
  }

  Future<List<Task>>findAll()async{
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(_tablename);
    return toList(result);
  }

  List<Task> toList(List<Map<String,dynamic>> mapaDeTarefas){
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas){
      final Task tarefa =  Task(linha[_name],  linha[_color], linha[_numeroPessoas], linha[_numeroPessoasPago], linha[_dataVencimento]);
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  Future <List<Task>> find(String servico) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String,dynamic>> result = await bancoDeDados.query(_tablename, 
    where: "$_name = ?", 
    whereArgs: [servico],);
    return toList(result);
  }
  delete(String servico)async{
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(_tablename, where: '$_name = ?', whereArgs: [servico]);
  }

  update(Task servico) async{
    final Database bancoDeDados = await getDatabase();
    Map<String, dynamic> taskMap = toMap(servico);
    return await bancoDeDados.update(_tablename, taskMap, where: '$_name = ?', whereArgs: [servico.nome]);
  }

}
