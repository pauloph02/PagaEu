import 'package:flutter/material.dart';
import '../data/models/pessoa_model.dart';
import '../data/people_dao.dart';

class PessoaListPage extends StatelessWidget {
  const PessoaListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste"),
         actions: [],
      ),
      body: Padding(padding: EdgeInsets.only(top: 30),
      child: FutureBuilder(
        future: PeopleDao().getAll(), 
        builder: (BuildContext context,
        AsyncSnapshot<List<PessoaModel>> snapshot
        ){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index){
              final PessoaModel pessoa = snapshot.data![index];
  	          return Padding(
                padding: EdgeInsets.only(left: 8, right: 4),
                child: Text(pessoa.nome),
                );
            },
          );
        }
        ),
      ),
      
    );
  }
}