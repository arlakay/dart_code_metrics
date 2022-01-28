import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../utils/node_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../../models/issue.dart';
import '../../../models/severity.dart';
import '../../models/rule.dart';
import '../../models/rule_documentation.dart';
import '../../rule_utils.dart';

part 'visitor.dart';

class NoCrossPackageExportsRule extends Rule {
  static const String ruleId = 'no-cross-package-exports';

  static const _warningMessage = 'Avoid exporting other packages in libraries.';

  NoCrossPackageExportsRule([Map<String, Object> config = const {}])
      : super(
          id: ruleId,
          documentation: const RuleDocumentation(
            name: 'No cross package exports',
            brief: 'Warns when a library exports different libraries, serving as their proxy.',
          ),
          severity: readSeverity(config, Severity.error),
          excludes: readExcludes(config),
        );

  @override
  Iterable<Issue> check(InternalResolvedUnitResult source) {
    final _visitor = _Visitor();

    source.unit.visitChildren(_visitor);

    if (!_visitor.isLibrary) {
      return [];
    }

    return _visitor.exports
        .map(
          (member) => createIssue(
            rule: this,
            location: nodeLocation(
              node: member,
              source: source,
              withCommentOrMetadata: true,
            ),
            message: _warningMessage,
          ),
        )
        .toList(growable: false);
  }
}
