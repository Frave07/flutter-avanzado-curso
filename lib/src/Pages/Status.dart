import 'package:band_names/src/Services/Socket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class StatusPage extends StatelessWidget
{

 @override
 Widget build(BuildContext context)
 {
   final socketServices = Provider.of<SocketServices>(context);
  
    return Scaffold(
       body: Center(
          child: Text('Estado : ${socketServices.serverStatus}'),
       ),
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.message),
         onPressed: (){
            
            socketServices.socket.emit('emitir-mensaje', { 'nombre': 'Flutter', 'mensaje': 'Listo!' } );
         },
       ),
     );
  }
}