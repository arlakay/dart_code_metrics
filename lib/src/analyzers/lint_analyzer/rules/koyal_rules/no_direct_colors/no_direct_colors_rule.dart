import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../utils/node_utils.dart';
import '../../../lint_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../../models/issue.dart';
import '../../../models/replacement.dart';
import '../../../models/severity.dart';
import '../../models/flutter_rule.dart';
import '../../rule_utils.dart';

part 'visitor.dart';

class NoDirectColorsRule extends FlutterRule {
  static const String ruleId = 'no-direct-colors';

  static const _failure = 'HciColors constants or color from ColorTheme should be used instead of Color.';

  NoDirectColorsRule([Map<String, Object> config = const {}])
      : super(
          id: ruleId,
          severity: readSeverity(config, Severity.error),
          excludes: readExcludes(config),
        );

  @override
  Iterable<Issue> check(InternalResolvedUnitResult source) {
    final _visitor = _Visitor();

    source.unit.visitChildren(_visitor);

    return _visitor._expressions
        .map((statement) => createIssue(
              rule: this,
              location: nodeLocation(node: statement, source: source),
              replacement: hciColorsReplacement(),
              message: _failure,
            ))
        .toList(growable: false);
  }
}

Replacement hciColorsReplacement() {
  const replacementComment = 'Please use HciColors constants or proper color from ColorTheme instead of Color';
  const color = 'TODO';

  const replacementText = 'HciColors.$color';

  return const Replacement(
    comment: replacementComment,
    replacement: replacementText,
  );
}
