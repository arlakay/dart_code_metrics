part of 'buttons_layout.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _expressions = <Expression>[];

  Iterable<Expression> get expressions => _expressions;

  @override
  // ignore: long-method
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    super.visitInstanceCreationExpression(node);
    final nodeName = node.staticType?.getDisplayString(withNullability: false);
    if (nodeName == 'PrimaryButton' || nodeName == 'SecondaryButton') {
      var isValid = false;
      if (node.parent is Expression) {
        final parentLv1Node = node.parent as Expression;
        dynamic argumentListNode;
        //Normal case
        if (parentLv1Node.parent is ArgumentList) {
          argumentListNode = parentLv1Node.parent;
        }
        //Case with condition like primaryButton: abc == true ? PrimaryButton() : null
        if (parentLv1Node.parent?.parent is ArgumentList) {
          argumentListNode = parentLv1Node.parent?.parent as ArgumentList;
        }
        if (argumentListNode != null && argumentListNode is ArgumentList) {
          if (argumentListNode.parent is InstanceCreationExpression) {
            final parentNode = argumentListNode.parent as InstanceCreationExpression;
            if (parentNode.staticType?.getDisplayString(withNullability: false) == 'HorizontalButtonsLayout' ||
                parentNode.staticType?.getDisplayString(withNullability: false) == 'VerticalButtonsLayout') {
              isValid = true;
            }
          }
        }
      }

      //Ignore showKoyalOverlay/showSuccessOverlay
      final parentLv1Node = node.parent;
      final parentLv2Node = parentLv1Node?.parent;
      final parentLv3Node = parentLv2Node?.parent;
      final parentLv4Node = parentLv3Node?.parent;
      var isKoyalOverlayDialog = false;
      var isSuccessOverlayDialog = false;
      if (parentLv4Node?.parent is MethodInvocation) {
        isKoyalOverlayDialog = (parentLv4Node?.parent as MethodInvocation).methodName.name == 'showKoyalOverlay';
        isSuccessOverlayDialog = (parentLv4Node?.parent as MethodInvocation).methodName.name == 'showSuccessOverlay';
      }
      if ((isKoyalOverlayDialog || isSuccessOverlayDialog) &&
          parentLv3Node is NamedExpression &&
          (parentLv3Node.name.label.name == 'primaryButtonBuilder' ||
              parentLv3Node.name.label.name == 'secondaryButtonBuilder')) {
        isValid = true;
      }

      dynamic koyalOverlayNode;
      //Ignore KoyalOverlay: normal case
      if (parentLv3Node is InstanceCreationExpression) {
        koyalOverlayNode = parentLv3Node;
      }
      //Ignore KoyalOverlay: has condition like primaryButton: abc == true : PrimaryButton() : null
      if (parentLv4Node is InstanceCreationExpression) {
        koyalOverlayNode = parentLv4Node;
      }
      if (koyalOverlayNode != null && koyalOverlayNode is InstanceCreationExpression) {
        final instanceName = koyalOverlayNode.staticType?.getDisplayString(withNullability: false) ?? '';
        var isContainButtonArgument = false;
        for (final element in koyalOverlayNode.argumentList.arguments) {
          final argumentName = (element as NamedExpression).name.label.name;
          if (argumentName == 'primaryButton' || argumentName == 'secondaryButton') {
            isContainButtonArgument = true;
          }
        }
        if (instanceName == 'KoyalOverlay' && isContainButtonArgument) {
          isValid = true;
        }
      }

      if (!isValid) {
        _expressions.add(node);
      }
    }
  }
}
