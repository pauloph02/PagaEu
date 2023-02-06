import 'package:paga_eu/components/task.dart';
import 'package:paga_eu/data/task_dao.dart';
import 'package:paga_eu/screens/form_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            onPressed: (){setState((){});
            },
            icon: const Icon(Icons.refresh)
            ),
           
        ],
        title: const Center(child: Text('PagaEu')) 
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(future: TaskDao().findAll(),builder: (context, snapshot) {
          List<Task>? items = snapshot.data;
          switch(snapshot.connectionState){

            case ConnectionState.none:
              return Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                    Text('Carregando')
                  ],
                ),
              );
              //break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
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
                  children: const [
                    CircularProgressIndicator(),
                    Text('Carregando')
                  ],
                ),
              );
              //break;
            case ConnectionState.done:
              if(snapshot.hasData && items != null){
                if(items.isNotEmpty){
                  return ListView.builder(itemCount: items.length, itemBuilder: (BuildContext context, int index){
                  final Task tarefa = items[index];
                  return InkWell(
                    child: tarefa);
          },
          );
                }
                return Center(
                  child: Column(
                    children: const [
                      Icon(Icons.error_outline, size: 128),
                      Text('Não Há nenhum serviço!', style: TextStyle(fontSize: 32),)
                    ]
                  )
                );
              }
              return const Text("Erro ao carregar tarefas");
              //break;
          } //return const Text('Erro desconhecido');
        }
        ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          ).then((value) => setState((){

          }));
          setState(() {
            
          });
        },
        child: const Icon(Icons.add),
      ),
        );
  }
}
