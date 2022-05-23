part of 'no_hci_colors_rule.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _expressions = <PrefixedIdentifier>[];
  final _hciColors = 'HciColors';

  Iterable<PrefixedIdentifier> get expressions => _expressions;

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    super.visitPrefixedIdentifier(node);
    
    if (node.prefix.toSource() == _hciColors) {
      if (_isBuildContextAvailable(node)) {
        _expressions.add(node);
      }
      _expressions.add(node);
    }
  }

  bool _isBuildContextAvailable(PrefixedIdentifier node) {
    final methodDeclaration = node.parent?.thisOrAncestorOfType<MethodDeclaration>();
    if (methodDeclaration != null) {
      final parameters = methodDeclaration.parameters?.parameters;
      if (parameters != null) {
        return parameters.isNotEmpty && 
          parameters.any((parameter) => isBuildContext(parameter.declaredElement?.type));
      }

      return false;
    }

    return false;
  }
}
