part of 'koyal_text_span.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _expressions = <InstanceCreationExpression>[];

  Iterable<InstanceCreationExpression> get expressions => _expressions;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    super.visitInstanceCreationExpression(node);

    if (node.staticType?.getDisplayString(withNullability: false) == 'TextSpan') {
      _expressions.add(node);
    }
  }
}
