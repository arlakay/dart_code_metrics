part of 'no_cross_package_exports.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _exports = <ExportDirective>[];
  bool isLibrary = false;

  Iterable<ExportDirective> get exports => _exports;

  @override
  void visitLibraryDirective(LibraryDirective node) {
    super.visitLibraryDirective(node);

    isLibrary = true;
  }

  @override
  void visitExportDirective(ExportDirective node) {
    super.visitExportDirective(node);

    final export = node.selectedUriContent?.contains('package');
    if (export != null && export == true) {
      _exports.add(node);
    }
  }
}
