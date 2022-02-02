class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Text(
      'a',
      key: Key('testKey'),
      style: TextStyleTheme.of(context).titleBig2,
      maxLines: 3,
      textAlign: TextAlign.center,
      softWrap: true,
      overflow: TextOverflow.elipsis,
    );

    Text(
      'b',
      key: Key('testKey'),
    );

    Text(
      'c',
      style: TextStyleTheme.of(context).titleBig2,
    );

    Text(
      'd',
      maxLines: 3,
    );

    Text(
      'e',
      textAlign: TextAlign.center,
    );

    Text(
      'f',
      softWrap: true,
    );

    Text(
      'f',
      overflow: TextOverflow.elipsis,
    );

    Text(
      'g',
      style: TextStyleTheme.of(context).somethingElse,
      maxLines: 3242,
      key: Key('testKey'),
      softWrap: false,
      textAlign: TextAlign.something,
      overflow: TextOverflow.somethingElse,
    );
    
    return Text('Lorem');
  }
}

class Widget {}

class StatelessWidget extends Widget {}

class Text extends Widget {
  String data;

  Text(this.data) : super();
}
