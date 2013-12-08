import 'dart:html';
import 'dart:convert';
import 'templates/row.dart';

void main() {
  HtmlElement form = query('#input-form');
  HtmlElement name = query('#name');
  HtmlElement input = query('#input');
  HtmlElement rows = query('#rows');
  WebSocket ws = new WebSocket('ws://localhost:8080/ws');
  ws.addEventListener('open', (event) {
    if (ws != null && ws.readyState == WebSocket.OPEN) {
      print('WebSocket connection succeed.');
    } else {
      print('WebSocket connection failed...');
    }
  });
  ws.addEventListener('error', (event) {
    print('WebSocket error [${event}]');
  });
  ws.addEventListener('message', (event) {
    Object data = JSON.decode(event.data);
    HtmlElement row = Row.left(data['name'], data['body']);
    rows.insertAdjacentElement('afterEnd', row);
    input.value = '';
  });

  sendMessage(String type, String message) {
    ws.send(JSON.encode({
      '_type': type,
      'name': name.value,
      'body': message,
    }));
  }

  form.addEventListener('submit', (event) {
    print('yea');
    event.preventDefault();
    String value = input.value;
    sendMessage('message', value);
  });
}