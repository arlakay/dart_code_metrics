part of 'no_native_input_elements_rule.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _expressions = <InstanceCreationExpression>[];
  final _nativeInputElements = [
    'Checkbox',
    'Slider',
    'TextFormField',
  ];

  Iterable<InstanceCreationExpression> get expressions => _expressions;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    super.visitInstanceCreationExpression(node);
    final nodeName = node.staticType?.getDisplayString(withNullability: false);
    if (_nativeInputElements.contains(nodeName)) {
      _expressions.add(node);
    }
  }
}
