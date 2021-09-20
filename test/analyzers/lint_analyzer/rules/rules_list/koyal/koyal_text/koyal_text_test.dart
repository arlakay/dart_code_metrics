@TestOn('vm')
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/severity.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/rules/koyal_rules/koyal_text/koyal_text.dart';
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
        severity: Severity.error,
      );
    });

    test('reports about found issues with the default config', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = KoyalTextRule().check(unit);

      RuleTestHelper.verifyIssues(
        issues: issues,
        startOffsets: [96, 317, 373, 453, 501, 565, 616, 683, 932],
        startLines: [4, 14, 19, 24, 29, 34, 39, 44, 54],
        startColumns: [5, 5, 5, 5, 5, 5, 5, 5, 12],
        endOffsets: [310, 366, 446, 494, 558, 609, 676, 914, 945],
        locationTexts: [
          '''
Text(
      'a',
      key: Key('testKey'),
      style: TextStyleTheme.of(context).titleBig2,
      maxLines: 3,
      textAlign: TextAlign.center,
      softWrap: true,
      overflow: TextOverflow.elipsis,
    )''',
          '''
Text(
      'b',
      key: Key('testKey'),
    )''',
          '''
Text(
      'c',
      style: TextStyleTheme.of(context).titleBig2,
    )''',
          '''
Text(
      'd',
      maxLines: 3,
    )''',
          '''
Text(
      'e',
      textAlign: TextAlign.center,
    )''',
          '''
Text(
      'f',
      softWrap: true,
    )''',
          '''
Text(
      'f',
      overflow: TextOverflow.elipsis,
    )''',
          '''
Text(
      'g',
      style: TextStyleTheme.of(context).somethingElse,
      maxLines: 3242,
      key: Key('testKey'),
      softWrap: false,
      textAlign: TextAlign.something,
      overflow: TextOverflow.somethingElse,
    )''',
          '''
Text('Lorem')''',
        ],
        messages: [
          'KoyalText should be used instead of Text.',
          'KoyalText should be used instead of Text.',
          'KoyalText should be used instead of Text.',
          'KoyalText should be used instead of Text.',
          'KoyalText should be used instead of Text.',
          'KoyalText should be used instead of Text.',
          'KoyalText should be used instead of Text.',
          'KoyalText should be used instead of Text.',
          'KoyalText should be used instead of Text.',
        ],
        replacements: [
          "KoyalText.TODO('a', key: Key('testKey'), maxLines: 3, textAlign: TextAlign.center, softWrap: true, overflow: TextOverflow.elipsis,)",
          "KoyalText.TODO('b', key: Key('testKey'),)",
          "KoyalText.TODO('c',)",
          "KoyalText.TODO('d', maxLines: 3,)",
          "KoyalText.TODO('e', textAlign: TextAlign.center,)",
          "KoyalText.TODO('f', softWrap: true,)",
          "KoyalText.TODO('f', overflow: TextOverflow.elipsis,)",
          "KoyalText.TODO('g', key: Key('testKey'), maxLines: 3242, textAlign: TextAlign.something, softWrap: false, overflow: TextOverflow.somethingElse,)",
          "KoyalText.TODO('Lorem',)",
        ],
      );
    });
  });
}
