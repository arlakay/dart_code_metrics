part of 'no_direct_padding_rule.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _expressions = <InstanceCreationExpression>[];
  final _nativePadding = 'Padding';

  Iterable<InstanceCreationExpression> get expressions => _expressions;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    super.visitInstanceCreationExpression(node);
    final nodeName = node.staticType?.getDisplayString(withNullability: false);
    if (_nativePadding == nodeName) {
      _expressions.add(node);
    }
  }
}
