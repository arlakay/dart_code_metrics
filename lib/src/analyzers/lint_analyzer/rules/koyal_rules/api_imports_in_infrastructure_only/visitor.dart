part of 'api_imports_in_infrastructure_only.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _imports = <ImportDirective>[];
  final _apiPackageKeywords = const [
    'selfcareapi',
    'mappapi',
    'identityapi',
    'mobilecommonapi'
  ];

  Iterable<ImportDirective> get imports => _imports;

  @override
  void visitImportDirective(ImportDirective node) {
    super.visitImportDirective(node);

    for (final element in _apiPackageKeywords) {
      final containsBannedKeyword =
          node.selectedUriContent?.contains(element) ?? false;

      if (containsBannedKeyword == true) {
        _imports.add(node);
        return;
      }
    }
  }
}
