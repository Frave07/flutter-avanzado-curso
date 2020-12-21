
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
    Online,
    Offline,
    Connecting
}

class SocketServices with ChangeNotifier
{
    ServerStatus _serverStatus = ServerStatus.Connecting;
    IO.Socket _socket;

    ServerStatus get serverStatus => this._serverStatus;
    IO.Socket get socket => this._socket; 

    SocketServices(){
      this._initConfig();
    }



    void _initConfig() {

    this._socket = IO.io('http://192.168.1.16:3000/',{
        'transports': ['websocket'],
        'autoConnect': true,
    });

    this._socket.on('connect', (_) {
        
        print('connect');
        this._serverStatus = ServerStatus.Online;
        notifyListeners();
    });

    this._socket.on('disconnect', (_) {

      print('Desconectado');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.connect();

  }
}