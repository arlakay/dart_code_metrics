part of 'no_native_buttons.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _expressions = <InstanceCreationExpression>[];
  final _nativeButtons = [
    'RaisedButton',
    'FlatButton',
    'TextButton',
    'ElevatedButton',
    'OutlinedButton',
  ];

  Iterable<InstanceCreationExpression> get expressions => _expressions;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    super.visitInstanceCreationExpression(node);
    final nodeName = node.staticType?.getDisplayString(withNullability: false);
    if (_nativeButtons.contains(nodeName)) {
      _expressions.add(node);
    }
  }
}
