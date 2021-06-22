@TestOn('vm')
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/severity.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/rules/koyal_rules/koyal_text_rule.dart';
import 'package:test/test.dart';

import '../../../../../../helpers/rule_test_helper.dart';

const _examplePath = 'koyal/koyal_text/examples/example.dart';

void main() {
  group('KoyalText', () {
    test('initialization', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = KoyalTextRule().check(unit);

      RuleTestHelper.verifyInitialization(
        issues: issues,
        ruleId: 'koyal-text',
        severity: Severity.style,
      );
    });

    test('reports about found issues with the default config', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = KoyalTextRule().check(unit);

      RuleTestHelper.verifyIssues(
        issues: issues,
        startOffsets: [96, 120],
        startLines: [4, 5],
        startColumns: [5, 12],
        endOffsets: [107, 133],
        locationTexts: [
          "Text('abc')",
          "Text('Lorem')",
        ],
        messages: [
          'KoyalText should be used instead of Text.',
          'KoyalText should be used instead of Text.',
        ],
      );
    });
  });
}
