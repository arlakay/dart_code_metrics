part of 'no_native_icons.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _expressions = <PrefixedIdentifier>[];
  final _nativeIcon = 'Icons';

  Iterable<PrefixedIdentifier> get expressions => _expressions;

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    super.visitPrefixedIdentifier(node);
    
    if (node.prefix.toSource() == _nativeIcon) {
      _expressions.add(node);
    }
  }
}
