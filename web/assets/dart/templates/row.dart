import 'dart:html';

class Row {
  static HtmlElement left(String name, String message) {
    return Row._row(Row._user(name) + Row._message(message));
  }

  static HtmlElement right(String name, String message) {
    return Row._row(Row._message(message) + Row._user(name));
  }

  static String _user(String name, {String classes: ''}) {
    return '''<div class="col-md-2 ${classes}">
      <p>${Row._escape(name)}</p>
    </div>''';
  }

  static String _message(String message, {String classes: ''}) {
    return '''<div class="col-md-10 ${classes}">
      <p>${Row._escape(message)}</p>
    </div>''';
  }

  static HtmlElement _row(String inside) {
    HtmlElement row = new DivElement();
    row.classes.add('row');
    row.appendHtml(inside);
    return row;
  }

  static String _escape(String text) {
    return text.replaceAll("&", "&amp;")
               .replaceAll("<", "&lt;")
               .replaceAll(">", "&gt;")
               .replaceAll('"', "&quot;")
               .replaceAll("'", "&apos;");
  }
}