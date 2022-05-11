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

class KoyalTextSpanRule extends FlutterRule {
  static const String ruleId = 'koyal-text-span';

  static const _failure = 'KoyalTextSpan should be used instead of TextSpan.';

  KoyalTextSpanRule([Map<String, Object> config = const {}])
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
              replacement: koyalTextSpanReplacement(statement),
              message: _failure,
            ))
        .toList(growable: false);
  }
}

// ignore: long-method
Replacement koyalTextSpanReplacement(InstanceCreationExpression textExpression) {
  const replacementComment = 'Use KoyalTextSpan';
  const constructorName = 'TODO';

  final args = textExpression.argumentList.arguments;
  final textArgument = args.first;

  Expression? textExp;
  Expression? childrenExp;
  Expression? recognizerExp;

  for (final expression in args) {
    if (expression is NamedExpression) {
      switch (expression.name.label.name) {
        case 'text':
          textExp = expression.expression;
          break;
        case 'children':
          childrenExp = expression.expression;
          break;
        case 'recognizer':
          recognizerExp = expression.expression;
          break;
      }
    }
  }

  var replacementText = 'KoyalTextSpan.$constructorName($textArgument';

  if (textExp != null) {
    replacementText += ', text: ${textExp.toSource()}';
  }

  if (childrenExp != null) {
    replacementText += ', children: ${childrenExp.toSource()}';
  }

  if (recognizerExp != null) {
    replacementText += ', recognizer: ${recognizerExp.toSource()}';
  }

  replacementText += ',)';

  return Replacement(
    comment: replacementComment,
    replacement: replacementText,
  );
}
