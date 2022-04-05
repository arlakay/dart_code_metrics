import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../../lint_analyzer.dart';
import '../../../../../utils/node_utils.dart';
import '../../../lint_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../models/flutter_rule.dart';
import '../../rule_utils.dart';

part 'visitor.dart';

class NoNativeIconsRule extends FlutterRule {
  static const String ruleId = 'no-native-icons';

  static const _failure =
      'KoyalIcons class should be used instead of Icons class.';

  NoNativeIconsRule([Map<String, Object> config = const {}])
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
              replacement: koyalTextReplacement(),
              message: _failure,
            ))
        .toList(growable: false);
  }
}

Replacement koyalTextReplacement() {
  const replacementComment =
      'Please use KoyalIcons instead of Icons';
      const iconName = 'TODO';

  const replacementText = 'KoyalIcons.$iconName';

  return const Replacement(
    comment: replacementComment,
    replacement: replacementText,
  );
}
