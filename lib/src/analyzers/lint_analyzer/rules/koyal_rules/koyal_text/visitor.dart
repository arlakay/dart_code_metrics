part of 'koyal_text.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _expressions = <InstanceCreationExpression>[];

  Iterable<InstanceCreationExpression> get expressions => _expressions;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    super.visitInstanceCreationExpression(node);

    if (node.staticType?.getDisplayString(withNullability: false) == 'Text') {
      _expressions.add(node);
    }
  }
}
