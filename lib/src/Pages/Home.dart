import 'package:flutter/material.dart';

import 'package:band_names/src/Models/BandModels.dart';

class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  List<BandModels> bands = [
      BandModels( id: '1', nombre: 'Frave', votos: 10),
      BandModels( id: '2', nombre: 'Programmer', votos: 8),
      BandModels( id: '3', nombre: 'Coders', votos: 6),
      BandModels( id: '4', nombre: 'Other', votos: 2),
  ];

 @override
 Widget build(BuildContext context)
 {
    return Scaffold(
        appBar: AppBar(
          title: Text('Band Names', style: TextStyle( color: Colors.black87)),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: ( context, i) => _bandTite( bands[i]) 
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black87,
            child: Icon(Icons.add),
            onPressed: showModalAgregar,
        ),
     );
  }

 Widget _bandTite( BandModels band ){
    
    return Dismissible(
          key: Key( band.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            
          },
          background: Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.red,
              child: Align(
                child: Row(children: [
                    Icon(Icons.delete_outline, color: Colors.white),
                    Text('Eliminar', style: TextStyle( color: Colors.white, fontSize: 19 )),
                ],),
              ),
          ),
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text( band.nombre.substring(0,2), style: TextStyle( fontWeight: FontWeight.bold )),
            ),
            title: Text( band.nombre ),
            trailing: Text( '${band.votos}', style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold )),
          ),
    );
 } 

 showModalAgregar(){
   
    final textController = new TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
          return AlertDialog(
            title: Text('Agregar Nuevo'),
            content: TextField(
              controller: textController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[200])),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.black87)),
                fillColor: Colors.grey[200],
                filled: true,
              ),
              style: TextStyle(fontSize: 19),
            ),
            actions: [
              MaterialButton(
                child: Text('Agregar', style: TextStyle(fontSize: 18, color: Colors.blue)),
                elevation: 0,
                color: Colors.blue[100],
                onPressed: (){
                    if( textController.text.length > 3 ){
                        this.bands.add( new BandModels(id: '5', nombre: textController.text, votos: 0 ));
                        setState(() {});
                        Navigator.pop(context);
                    }
                }
              )
            ],
          );
      },
    );
 }

 
}