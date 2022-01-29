part of 'no_cross_package_exports.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _exports = <ExportDirective>[];

  Iterable<ExportDirective> get exports => _exports;

  @override
  void visitExportDirective(ExportDirective node) {
    super.visitExportDirective(node);

    final export = node.selectedUriContent?.contains('package');
    if (export != null && export) {
      _exports.add(node);
    }
  }
}
