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

class KoyalScaffoldRule extends FlutterRule {
  static const String ruleId = 'koyal-scaffold';

  static const _failure = 'KoyalScaffold should be used instead of Scaffold.';

  KoyalScaffoldRule([Map<String, Object> config = const {}])
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
              replacement: koyalScaffoldReplacement(statement),
              message: _failure,
            ))
        .toList(growable: false);
  }
}

// ignore: long-method
Replacement koyalScaffoldReplacement(InstanceCreationExpression textExpression) {
  const replacementComment = 'Use KoyalScaffold';
  const constructorName = 'TODO';

  final args = textExpression.argumentList.arguments;
  final textArgument = args.first;

  Expression? keyExp;
  Expression? appBarExp;
  Expression? bodyExp;
  Expression? floatingActionButtonExp;
  Expression? persistentFooterButtonsExp;
  Expression? drawerExp;
  Expression? bottomNavigationBarExp;
  Expression? bottomSheetExp;
  Expression? backgroundColorExp;
  Expression? resizeToAvoidBottomInsetExp;
  Expression? primaryExp;
  Expression? extendBodyExp;

  for (final expression in args) {
    if (expression is NamedExpression) {
      switch (expression.name.label.name) {
        case 'key':
          keyExp = expression.expression;
          break;
        case 'appBar':
          appBarExp = expression.expression;
          break;
        case 'body':
          bodyExp = expression.expression;
          break;
        case 'floatingActionButton':
          floatingActionButtonExp = expression.expression;
          break;
        case 'persistentFooterButtons':
          persistentFooterButtonsExp = expression.expression;
          break;
        case 'drawer':
          drawerExp = expression.expression;
          break;
        case 'bottomNavigationBar':
          bottomNavigationBarExp = expression.expression;
          break;
        case 'bottomSheet':
          bottomSheetExp = expression.expression;
          break;
        case 'backgroundColor':
          backgroundColorExp = expression.expression;
          break;
        case 'resizeToAvoidBottomInset':
          resizeToAvoidBottomInsetExp = expression.expression;
          break;
        case 'primary':
          primaryExp = expression.expression;
          break;
        case 'extendBody':
          extendBodyExp = expression.expression;
          break;
      }
    }
  }

  var replacementText = 'KoyalScaffold.$constructorName($textArgument';

  if (keyExp != null) {
    replacementText += ', key: ${keyExp.toSource()}';
  }

  if (appBarExp != null) {
    replacementText += ', appBar: ${appBarExp.toSource()}';
  }

  if (bodyExp != null) {
    replacementText += ', body: ${bodyExp.toSource()}';
  }

  if (floatingActionButtonExp != null) {
    replacementText += ', floatingActionButton: ${floatingActionButtonExp.toSource()}';
  }

  if (persistentFooterButtonsExp != null) {
    replacementText += ', persistentFooterButtons: ${persistentFooterButtonsExp.toSource()}';
  }

  if (drawerExp != null) {
    replacementText += ', drawer: ${drawerExp.toSource()}';
  }

  if (bottomNavigationBarExp != null) {
    replacementText += ', bottomNavigationBar: ${bottomNavigationBarExp.toSource()}';
  }

  if (bottomSheetExp != null) {
    replacementText += ', bottomSheet: ${bottomSheetExp.toSource()}';
  }

  if (backgroundColorExp != null) {
    replacementText += ', backgroundColor: ${backgroundColorExp.toSource()}';
  }

  if (resizeToAvoidBottomInsetExp != null) {
    replacementText += ', resizeToAvoidBottomInset: ${resizeToAvoidBottomInsetExp.toSource()}';
  }

  if (primaryExp != null) {
    replacementText += ', primary: ${primaryExp.toSource()}';
  }

  if (extendBodyExp != null) {
    replacementText += ', extendBody: ${extendBodyExp.toSource()}';
  }

  replacementText += ',)';

  return Replacement(
    comment: replacementComment,
    replacement: replacementText,
  );
}
