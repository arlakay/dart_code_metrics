import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../../lint_analyzer.dart';
import '../../../../../utils/node_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../../models/issue.dart';
import '../../../models/severity.dart';
import '../../models/rule.dart';
import '../../models/rule_documentation.dart';
import '../../rule_utils.dart';

part 'visitor.dart';

class KoyalTextRule extends Rule {
  static const String ruleId = 'koyal-text';

  static const _failure = 'KoyalText should be used instead of Text.';

  KoyalTextRule([Map<String, Object> config = const {}])
      : super(
          id: ruleId,
          documentation: const RuleDocumentation(
            name: 'Koyal Text',
            brief: 'Checks that there is no constructor of native Text.',
          ),
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
              replacement: koyalTextReplacement(statement),
              message: _failure,
            ))
        .toList(growable: false);
  }
}

// ignore: long-method
Replacement koyalTextReplacement(InstanceCreationExpression textExpression) {
  const replacementComment = 'Use KoyalText';
  const constructorName = 'TODO';

  final args = textExpression.argumentList.arguments;
  final textArgument = args.first;

  Expression? keyExp;
  Expression? maxLinesExp;
  Expression? textAlignExp;
  Expression? softWrapExp;
  Expression? overflowExp;

  for (final expression in args) {
    if (expression is NamedExpression) {
      switch (expression.name.label.name) {
        case 'key':
          keyExp = expression.expression;
          break;
        case 'maxLines':
          maxLinesExp = expression.expression;
          break;
        case 'textAlign':
          textAlignExp = expression.expression;
          break;
        case 'softWrap':
          softWrapExp = expression.expression;
          break;
        case 'overflow':
          overflowExp = expression.expression;
          break;
      }
    }
  }

  var replacementText = 'KoyalText.$constructorName($textArgument';

  if (keyExp != null) {
    replacementText += ', key: ${keyExp.toSource()}';
  }

  if (maxLinesExp != null) {
    replacementText += ', maxLines: ${maxLinesExp.toSource()}';
  }

  if (textAlignExp != null) {
    replacementText += ', textAlign: ${textAlignExp.toSource()}';
  }

  if (softWrapExp != null) {
    replacementText += ', softWrap: ${softWrapExp.toSource()}';
  }

  if (overflowExp != null) {
    replacementText += ', overflow: ${overflowExp.toSource()}';
  }

  replacementText += ',)';

  return Replacement(
    comment: replacementComment,
    replacement: replacementText,
  );
}
