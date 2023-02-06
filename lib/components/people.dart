import 'package:flutter/material.dart';
import '../data/people_dao.dart';


// ignore: must_be_immutable
class People extends StatefulWidget {
  //late int? pessoaID;
  final String nome;
   int pago = 0;
   final String servico;
  People( this.nome, this.pago, this.servico, /* this.id */ [Key? key,])
      : super(key: key);




  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  Color color =  const Color(0x12345678);
  Color cor =  const Color(0xff610092);
  
  @override
  Widget build(BuildContext context) {
    bool valor;
     if(widget.pago == 0){
      valor = false;
    }else{
      valor = true;
    }
   
   
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: 
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormField(
                    initialValue: false,
                    builder: (field){
                      return CheckboxListTile(
                      title: Text(widget.nome, style: const TextStyle(fontSize: 18, color: Colors.black),),
                      value: valor,
                      
                       onChanged: (value){
                        valor = !(valor);
                        if(widget.pago == 0){
                          widget.pago = 1;
                        }else{
                          widget.pago = 0;
                        }
                       
                          PeopleDao().update(People(widget.nome, widget.pago, widget.servico, /* widget.id */));
                        field.didChange(value);
                        
                         
                        setState;
                      },
                      secondary: IconButton(
                        color: Colors.red,
                        icon: const Icon(Icons.remove_circle),
                        onPressed: (){PeopleDao().delete(widget.nome);
                        setState;
                        },
                      ),
                      );
                    } 
                  ),
              
                ],
              ),
            
          
    );  
    
  }
}
