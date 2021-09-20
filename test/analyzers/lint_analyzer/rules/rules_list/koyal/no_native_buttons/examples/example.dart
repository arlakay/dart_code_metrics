class ButtonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ElevatedButton(key: Key('testKey'), onPressed: () {});
    RaisedButton(key: Key('testKey'), onPressed: () {});
    FlatButton(key: Key('testKey'), onPressed: () {});
    TextButton(key: Key('testKey'), onPressed: () {});
    return OutlinedButton(key: Key('testKey'), onPressed: () {});
  }
}

class Widget {}

class StatelessWidget extends Widget {}

class ElevatedButton extends Widget {
  String data;
  ElevatedButton(this.data) : super();
}

class RaisedButton extends Widget {
  String data;
  RaisedButton(this.data) : super();
}

class FlatButton extends Widget {
  String data;
  ElevatedButton(this.data) : super();
}

class TextButton extends Widget {
  String data;
  TextButton(this.data) : super();
}

class OutlinedButton extends Widget {
  String data;
  OutlinedButton(this.data) : super();
}
