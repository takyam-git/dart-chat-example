import 'dart:io';
import 'dart:convert';

List<WebSocket> connections = [];

void main() {
  HttpServer.bind('localhost', 8080).then((HttpServer server) {
    server.where((request) => request.uri.path == '/ws').transform(new WebSocketTransformer()).listen((WebSocket ws) {
      connections.add(ws);
      wsHandler(ws);
    });
  });
}

void wsHandler(WebSocket ws) {
  print('new connection has come');
  ws.listen((message) {
    Object data = JSON.decode(message);
    for (WebSocket connection in connections) {
      connection.add(JSON.encode({
        '_type': 'message',
        'name' : data['name'],
        'body' : data['body'],
      }));
    }
  }, onDone: (() {
    print('connection ${ws.hashCode} closed with ${ws.closeCode} for ${ws.closeReason}');
  }));
}