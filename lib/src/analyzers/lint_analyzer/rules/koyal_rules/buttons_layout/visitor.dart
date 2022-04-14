part of 'buttons_layout.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _expressions = <Expression>[];

  Iterable<Expression> get expressions => _expressions;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    super.visitInstanceCreationExpression(node);
    final nodeName = node.staticType?.getDisplayString(withNullability: false);
    if (nodeName == 'PrimaryButton' || nodeName == 'SecondaryButton') {
      var isValid = false;
      if (node.parent is Expression) {
        final parentLv1Node = node.parent as Expression;
        if (parentLv1Node.parent is ArgumentList) {
          final parentLv2Node = parentLv1Node.parent as ArgumentList;
          if (parentLv2Node.parent is InstanceCreationExpression) {
            final parentLv3Node = parentLv2Node.parent as InstanceCreationExpression;
            if (parentLv3Node.staticType?.getDisplayString(withNullability: false) == 'HorizontalButtonsLayout' ||
                parentLv3Node.staticType?.getDisplayString(withNullability: false) == 'VerticalButtonsLayout') {
              isValid = true;
            }
          }
        }
      }
      if (!isValid) {
        _expressions.add(node);
      }
    }
  }
}
