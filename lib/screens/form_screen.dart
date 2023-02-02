import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


import '../components/task.dart';
import '../data/task_dao.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  Widget buildColorPicker() => ColorPicker(
    pickerColor: pickerColor,
   onColorChanged: (color) => setState(() => pickerColor = color),
   );

  void pickColor(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Escolha sua cor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildColorPicker(),
          TextButton(
            child: const Text('Confirmar', style: TextStyle(fontSize: 20),),
            onPressed: () => Navigator.of(context).pop(),
             ),
        ],
      ),
    )
  );
  DateTime date = DateTime(15,12,2022);
  TextEditingController nameController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController numeroPessoasController = TextEditingController();
  TextEditingController numeroPessoasPagoController = TextEditingController();
    Color pickerColor = Color.fromARGB(255, 0, 117, 108);
    Color currentColor = const Color(0xff443a49);

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value){
     if(value != null && value.isEmpty){
       return true;
     }
     return false;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Novo Serviço'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                color: pickerColor,
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
                      style: TextStyle(color: Colors.black),
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return 'Insira o nome da Tarefa';
                        }
                        return null;
                      },
                      controller: nameController,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Serviço a ser dividido',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black),
                        
                      ),
                    ),
                  ),
                 
                  
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      onChanged: (text) {
                        setState(() {});
                      },
                      validator: (value) {
                        /* if (valueValidator(value)) {
                          return 'Insira uma Cor';
                        } */
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      controller: colorController,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Cor de fundo',
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black)
                      ),
                      onTap: () async {
                        pickColor(context);
                        colorController.text = "$pickerColor";
                         currentColor = pickerColor;
                      } ,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Data de Vencimento',
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.black)
                        ),
                        // ignore: body_might_complete_normally_nullable
                        validator: (value){
                          if(value == null ||value.isEmpty){
                              return 'Insira uma data válida.';
                        }},
                        readOnly: true,
                          showCursor: true,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                               initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                 lastDate: DateTime(2100));
                                 if (newDate == null) return;

                          setState(() {
                            dataController.text = "${newDate.day}/${newDate.month}/${newDate.year}";
                            date = newDate;
                            },
                            );
                          },
                          controller: dataController,
                      ),
                    ),
                  ), 
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        
                        TaskDao().save(Task(nameController.text, pickerColor.toString(), '0' ,'0',dataController.text, ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Criando uma nova Tarefa'),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Adicionar!'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
