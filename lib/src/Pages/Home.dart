import 'package:band_names/src/Services/Socket.dart';
import 'package:flutter/material.dart';

import 'package:band_names/src/Models/BandModels.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  List<BandModels> bands = [];

  @override
  void initState() {
    
    final socketServices = Provider.of<SocketServices>(context, listen: false);
    socketServices.socket.on('bandas-activas', ( payload ){
     
        this.bands = ( payload as List ).map( (banda) => BandModels.fromMap( banda )).toList();
        setState(() { });
    });

    super.initState();
  }

  @override
  void dispose() {
    final socketServices = Provider.of<SocketServices>(context, listen: false);
    socketServices.socket.off('bandas-activas');
    super.dispose();
  }

 @override
 Widget build(BuildContext context)
 {
    final socketServices = Provider.of<SocketServices>(context);
    
    return Scaffold(
        appBar: AppBar(
          title: Text('Band Names', style: TextStyle( color: Colors.black87)),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
          actions: [
              Container(
                margin: EdgeInsets.only( right: 8.0 ),
                child: ( socketServices.serverStatus == ServerStatus.Online )
                       ? Icon(Icons.check_circle, color: Colors.blue[400])
                       : Icon(Icons.offline_bolt, color: Colors.red)
              )
          ],
        ),
        body: Column(
          children: [

              _mostrarGrafica(),

              Expanded(
                child: ListView.builder(
                    itemCount: bands.length,
                    itemBuilder: ( context, i) => _bandTite( bands[i]) 
                  ),
              ),
                 
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black87,
            child: Icon(Icons.add),
            onPressed: showModalAgregar,
        ),
     );
  }

 Widget _bandTite( BandModels band ){

    final socketServices = Provider.of<SocketServices>(context, listen: false);

    return Dismissible(
          key: Key( band.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
              socketServices.socket.emit('eliminar-banda', { 'id': band.id });
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
            onTap: (){
               socketServices.socket.emit('votar-banda', { 'id': band.id });
            },
          ),
    );
 } 

 showModalAgregar(){
   
    final textController = new TextEditingController();
    final socketServices = Provider.of<SocketServices>(context, listen: false);

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
                        socketServices.socket.emit('agregar-voto', { 'nombre': textController.text });
                    }
                    Navigator.pop(context);
                }
              )
            ],
          );
      },
    );
 }

 Widget _mostrarGrafica(){
    
    Map<String, double> dataMap = new Map();

    bands.forEach( (banda) {
        dataMap.putIfAbsent( banda.nombre , () => banda.votos.toDouble() );
    });

    final List<Color> colorList = [
        Colors.blue[200],
        Colors.blue[50],
        Colors.pink[200],
        Colors.pink[50],
        Colors.green[200],
        Colors.green[500],
    ];

    return Container(
          padding: EdgeInsets.only(top: 10),
          child: PieChart(
            dataMap: dataMap,
            chartType: ChartType.ring,
            colorList: colorList,
          
      ),
    );
 }

 
}