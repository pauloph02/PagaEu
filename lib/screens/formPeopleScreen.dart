import 'package:flutter/material.dart';

import '../components/people.dart';
import '../data/people_dao.dart';



// ignore: must_be_immutable
class FormPeopleScreen extends StatefulWidget {
  final String servico;
  Color cor;
   FormPeopleScreen({Key? key, required this.taskContext, required this.servico, required this.cor}) : super(key: key);

  final BuildContext taskContext;

  @override
  State<FormPeopleScreen> createState() => _FormPeopleScreenState();
}

class _FormPeopleScreenState extends State<FormPeopleScreen> {
  TextEditingController nome = TextEditingController();
  TextEditingController pago = TextEditingController();
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PagaEu'),
          backgroundColor: widget.cor,
          centerTitle: true,
          
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            
            children: [
              const SizedBox(height: 15,),
               Container(
                    height: 140,
                    
                    decoration: BoxDecoration(
                      color: widget.cor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (String? value) {
                              if (value == null || value.isEmpty){
                                return 'Insira o nome da pessoa';
                              }
                              return null;
                            },
                            controller: nome,
                            textAlign: TextAlign.left,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Pessoa a ser adicionada',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                        
            ]
            ),
            
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                            style: (
                              ElevatedButton.styleFrom(
                                backgroundColor: widget.cor,
                                
                                
                              )
                            ),
                            onPressed: () {
                              
                              //if (_formKey.currentState!.validate()) 
                                // print(nameController.text);
                                // print(difficultyController.text);
                                // print(imageController.text);
                                PeopleDao().save(People(nome.text, 0, widget.servico, ));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Criando uma nova Tarefa'),
                                  ),
                                );
                                setState(() {
                                  
                                });
                                Navigator.pop(context);
                                setState(() {
                                  
                                });
                              
                            },
                            child: const Text('Adicionar!'),
                          ),
                  ),
                    ]   
      ),
        )
      )
      );
      
    
    
    
          
        
    
    
  }
  
  void setarEstado() {
    setState(() {
      
    });
  }
} 