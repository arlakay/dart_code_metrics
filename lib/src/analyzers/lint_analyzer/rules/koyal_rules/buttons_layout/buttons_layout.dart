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

class ButtonsLayoutRule extends FlutterRule {
  static const String ruleId = 'buttons-layout';

  static const _failure =
      'Primary and Secondary buttons must always have one of HorizontalButtonsLayout or VerticalButtonsLayout widgets as its parent.';

  ButtonsLayoutRule([Map<String, Object> config = const {}])
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
      replacement: textReplacement(),
      message: _failure,
    )).toList(growable: false);
  }
}

Replacement textReplacement() {
  const replacementComment = 'Please use HorizontalButtonsLayout or VerticalButtonsLayout to wrap the buttons';

  const replacementText = '';

  return const Replacement(
    comment: replacementComment,
    replacement: replacementText,
  );
}
