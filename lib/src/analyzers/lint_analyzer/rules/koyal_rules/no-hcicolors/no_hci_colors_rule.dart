import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../../lint_analyzer.dart';
import '../../../../../utils/node_utils.dart';
import '../../../lint_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../flutter_rule_utils.dart';
import '../../models/flutter_rule.dart';
import '../../rule_utils.dart';

part 'visitor.dart';

class NoHciColorsRule extends FlutterRule {
  static const String ruleId = 'no-hcicolors';

  static const _failure =
      'Named color from ColorTheme class should be used instead of HciColors class.';

  NoHciColorsRule([Map<String, Object> config = const {}])
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
              replacement: colorThemeReplacement(),
              message: _failure,
            ))
        .toList(growable: false);
  }
}

Replacement colorThemeReplacement() {
  const replacementComment = 'Please use ColorTheme.of(context) instead of HciColors';

  const colorName = 'TODO';

  const replacementText = 'ColorTheme.of(context).$colorName';

  return const Replacement(
    comment: replacementComment,
    replacement: replacementText,
  );
}
