// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:paga_eu/components/people.dart';
import 'package:paga_eu/components/task.dart';
import 'package:paga_eu/data/domain/entity/pessoa_entity.dart';
import 'package:paga_eu/data/people_dao.dart';
import 'package:paga_eu/data/task_dao.dart';
import 'package:flutter/material.dart';
import 'package:paga_eu/mobx_store/pessoa_store.dart';

import 'formPeopleScreen.dart';


// ignore: must_be_immutable
class ServiceScreen extends StatefulWidget {
    final String nome;
    Color cor;
     String numeroPessoas ;
    final String dataVencimento;
     String numeroPessoasPago;

  ServiceScreen({Key? key,  required this.nome, required this.cor, required this.numeroPessoas, required this.numeroPessoasPago,   required this.dataVencimento, }) : super(key: key);
  @override
   State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  _dialog(){
    TextEditingController nomeform = TextEditingController();
    showDialog(
      context: context,
       builder: (_){
        return AlertDialog(
          title: Text('Adicionar pessoa'),
          content: TextField(
            onChanged: (value){
              // ignore: unused_local_variable
              GetIt.I.get<PessoaStore>().atualizarNome(nome: value);
              String nomeform = value;
            },
            controller: nomeform,
            decoration: InputDecoration(
              border: OutlineInputBorder( ),
              labelText: 'Nova Pessoa'
            ),
          ),
          actions: <Widget>[
            Observer(
              builder: (_){
                return TextButton(
              onPressed: _pessoaStore.dadosPreenchidos ? (){
                // ignore: unnecessary_null_comparison
                if(nomeform.text == '' || nomeform.text == null || nomeform.text.isEmpty){
                  return ;
                }else{
                  PeopleDao().save(People(nomeform.text, 0, widget.nome, ));
                  GetIt.I.get<PessoaStore>().atualizarPago(pago: '0');
                  GetIt.I.get<PessoaStore>().atualizarServico(servico: widget.nome);
                  _botaoGravar;
                  setState(() {
                    
                  });
                Navigator.pop(context);
                
                }
                
              } : null,
              child: Text('Salvar'),
            );
              },
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                setState(() {
                  
                });
              },
              child: Text('Cancelar'),
            ),
          ],
        );
       }
       );

  }
  
  final _pessoaStore = GetIt.I.get<PessoaStore>();

  @override
  Widget build(BuildContext context) {
    String colorString = widget.cor.toString(); // Color(0x12345678)
    String valueString = colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = Color(value);
    widget.cor = otherColor;
    // ignore: unused_local_variable
    bool valor = false;

    
    return Scaffold(
      appBar: AppBar(
        title: (Text(widget.nome,)),
        centerTitle: true,
        backgroundColor: widget.cor,
        actions: [
         
          IconButton(
            onPressed: (){
              setState((){});
              


            },
            icon: Icon(Icons.refresh)
            ),
           ],
      ), 
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        hoverColor: widget.cor,
        backgroundColor: widget.cor,
        
        onPressed:()  {
          /* await _dialog(); */
           Navigator.push(
            context,
          MaterialPageRoute(
            builder: (contextNew) => FormPeopleScreen(
              cor: otherColor, servico: widget.nome, taskContext: context,)
              )
              ).then((value) => setState(() {
                
              },));
          
          setState(() {},);

        } ,
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body:  
      
          Padding(
            padding: EdgeInsets.all(1),
              child: FutureBuilder<List<People>>(
                future: PeopleDao().findAllTeste() ,builder: (context, snapshot) {
                    List<People>? items = snapshot.data;
                     
                     switch(snapshot.connectionState){
               
                           case ConnectionState.none:
                             return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando')
                    ],
                  ),
                             );
                             // break;
                           case ConnectionState.waiting:
                             return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando')
                    ],
                  ),
                             );
                             // break;
                           case ConnectionState.active:
                             return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando')
                    ],
                  ),
                             );
                             // break;
                           case ConnectionState.done:
                             if(snapshot.hasData && items != null){
                  if(items.isNotEmpty){
                    return Observer(
                      builder: (context) {
                        return ListView.builder (itemCount: items.length, itemBuilder: (BuildContext context, int index) {
                    final People pessoa = items[index];
                    int numeroPessoasTotal = 0;
                    int numeroPessoasPagoTotal = 0;

                    for (var element in items) { if(element.servico == widget.nome){numeroPessoasTotal += 1; }
                    
                    }

                    for (var element in items) { if(element.pago == 1 && element.servico == widget.nome) {
                      numeroPessoasPagoTotal ++;
                      
                    }
                    }
                    widget.numeroPessoas = numeroPessoasTotal.toString();
                    widget.numeroPessoasPago = numeroPessoasPagoTotal.toString();
                    TaskDao().update(Task(widget.nome, widget.cor.toString(), widget.numeroPessoas, widget.numeroPessoasPago, widget.dataVencimento));
                    if( pessoa.servico == widget.nome ){
             
             
                      return pessoa;
                    
                        
                          
                          
                    
                    } else {
                      
                      return Text('', style: TextStyle(fontSize: 0),);
                      
                      
                      }
                        
                    
                         },

                         
                         );
                      },
                    ); 
                  }
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.error_outline, size: 128),
                        Text('Não Há nenhuma pessoa!', style: TextStyle(fontSize: 32),)
                      ]
                    )
                  );
                             }
                             return Text("Erro ao carregar pessoas");
                             //break;
                         } //return Text('Erro desconhecido');
                       }
               
               
               
               
               
                            
                      
                    )
                  
               
                   
                             
                         ),
                         bottomNavigationBar: BottomAppBar(
                          
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50,
          padding: EdgeInsets.fromLTRB(20,0,20,0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pago: ${widget.numeroPessoasPago}/${widget.numeroPessoas}', style: TextStyle(
                fontSize: 18
              ),),
              Text(widget.dataVencimento, style: TextStyle(
                fontSize: 18
              ),)
            ],
          ),
        ),
      ),
      
                 //]
              // ,
         
              
             
         // ),
         // ),
      
          
          
      );

      
  }
  setarEstado(){
    setState(() {
      
    });
  }

  _botaoGravar()async{
    await PeopleDao().create(PessoaEntity(nome: _pessoaStore.nome, pago: _pessoaStore.pago, servico: _pessoaStore.servico));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pessoa Cadastrada")));

  }
  
} 