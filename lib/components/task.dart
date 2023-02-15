import 'package:paga_eu/screens/initial_screen.dart';
import 'package:paga_eu/screens/serviceScreen.dart';
import 'package:flutter/material.dart';
import '../data/task_dao.dart';


// ignore: must_be_immutable
class Task extends StatefulWidget {
  final String nome;
  final String cor;
  final String numeroPessoas;
  final String dataVencimento;
  final String numeroPessoasPago;
  int nivel;
  Task(this.nome, this.cor, this.numeroPessoas, this.numeroPessoasPago, this.dataVencimento, [this.nivel = 0, Key? key,])
      : super(key: key);




  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  Color color =  const Color(0x12345678);
  Color cor =  const Color(0xff610092);
  
  @override
  Widget build(BuildContext context) {
    String colorString = widget.cor.toString(); // Color(0x12345678)
    String valueString = colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = Color(value);            
     mostrarDetalhes(String nome, Color cor,  String numeroPessoas,  String numeroPessoasPago,  String dataVencimento, ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceScreen(nome: nome, cor: otherColor,  numeroPessoas: numeroPessoas, numeroPessoasPago: numeroPessoasPago,   dataVencimento: dataVencimento, ),
      ),
    );
  }     
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: otherColor, border: Border.all(width: 2),/* border: Border(
                  bottom: BorderSide(style: BorderStyle.solid, color: Colors.black, width: 2)
                ) */),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: otherColor,
                  border: Border.all(width: 2)
                //border: Border(bottom: BorderSide(color: Colors.black, style: BorderStyle.solid, width: 50))
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 8, 8, 0),
                                child: Text(
                                  widget.nome,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    overflow: TextOverflow.ellipsis,
                                    
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        
                      ],
                    ),
                     SizedBox(
                      
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: otherColor),
                          onPressed: (){
                           mostrarDetalhes(widget.nome, otherColor,  widget.numeroPessoas,   widget.numeroPessoasPago,  widget.dataVencimento); 
                           
                          /* Navigator.pushReplacement(context, MaterialPageRoute(builder: 
                          (context) => PessoaListPage())); */

                        },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.visibility_outlined, color: Colors.white,),
                              
                            ],
                          )),
                    ), 
                    SizedBox(
                      
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: otherColor),
                          onPressed: (){
                          TaskDao().delete(widget.nome);
                           setState(() {
                             setState(() {
                               
                             });
                           });
                      
                        },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.delete, color: Colors.white),
                              
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: 
                        Text(
                          ' Pago: ${widget.numeroPessoasPago}/${widget.numeroPessoas}',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(widget.dataVencimento, style: const TextStyle(color: Colors.white, fontSize: 16),),
                    )
            ]
            ),
                ],
              ),
            ],
          ),
    );  
    
  }
}
