import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../utils/node_utils.dart';
import '../../../lint_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../../models/issue.dart';
import '../../../models/severity.dart';
import '../../models/flutter_rule.dart';
import '../../rule_utils.dart';

part 'visitor.dart';

class ApiImportsInInfrastructureOnly extends FlutterRule {
  static const String ruleId = 'api-imports-in-infrastructure-only';

  static const _warningMessage =
      'Avoid using API classes outside of infrastructure layer. Map them to domain models instead.';

  final _bannedPathKeywords = const ['presentation', 'domain', 'application'];

  ApiImportsInInfrastructureOnly([Map<String, Object> config = const {}])
      : super(
          id: ruleId,
          severity: readSeverity(config, Severity.error),
          excludes: readExcludes(config),
        );

  @override
  Iterable<Issue> check(InternalResolvedUnitResult source) {
    // first - filter files only in banned folders
    var _isInBannedPath = false;
    for (final _bannedPathKeyword in _bannedPathKeywords) {
      _isInBannedPath |= source.path.contains(_bannedPathKeyword);
    }

    // leave if we are not in banned folder
    if (_isInBannedPath == false) {
      return List.empty();
    }

  
    final _visitor = _Visitor();

    // check all imports
    source.unit.visitChildren(_visitor);

    return _visitor.imports
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
