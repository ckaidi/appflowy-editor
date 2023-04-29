import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_editor/src/editor/block_component/base_component/markdown_format_helper.dart';

/// Convert '[] ' to unchecked todo list
///
/// - support
///   - desktop
///   - mobile
///   - web
///
CharacterShortcutEvent formatEmptyBracketsToUncheckedBox =
    CharacterShortcutEvent(
  key: 'format empty square brackets to unchecked todo list',
  character: ' ',
  handler: (editorState) async {
    return _formatSymbolToUncheckedBox(
      editorState: editorState,
      symbol: '[]',
    );
  },
);

/// Convert '-[] ' to unchecked todo list
///
/// - support
///   - desktop
///   - mobile
///   - web
///
CharacterShortcutEvent formatHyphenEmptyBracketsToUncheckedBox =
    CharacterShortcutEvent(
  key: 'format hyphen and empty square brackets to unchecked todo list',
  character: ' ',
  handler: (editorState) async {
    return _formatSymbolToUncheckedBox(
      editorState: editorState,
      symbol: '-[]',
    );
  },
);

/// Convert '[x] ' to checked todo list
///
/// - support
///   - desktop
///   - mobile
///   - web
///
CharacterShortcutEvent formatFilledBracketsToCheckedBox =
    CharacterShortcutEvent(
  key: 'format filled square brackets to checked todo list',
  character: ' ',
  handler: (editorState) async {
    return _formatSymbolToCheckedBox(
      editorState: editorState,
      symbol: '[x]',
    );
  },
);

/// Convert '-[x] ' to checked todo list
///
/// - support
///   - desktop
///   - mobile
///   - web
///
CharacterShortcutEvent formatHyphenFilledBracketsToCheckedBox =
    CharacterShortcutEvent(
  key: 'format hyphen and filled square brackets to checked todo list',
  character: ' ',
  handler: (editorState) async {
    return _formatSymbolToCheckedBox(
      editorState: editorState,
      symbol: '-[x]',
    );
  },
);

Future<bool> _formatSymbolToUncheckedBox({
  required EditorState editorState,
  required String symbol,
}) async {
  assert(symbol == '[]' || symbol == '-[]');

  return formatMarkdownSymbol(
    editorState,
    (node) => node.type != 'todo_list',
    (text, _) => text == symbol,
    (_, node, delta) => Node(
      type: 'todo_list',
      attributes: {
        'checked': false,
        'delta': delta.compose(Delta()..delete(symbol.length)).toJson(),
      },
    ),
  );
}

Future<bool> _formatSymbolToCheckedBox({
  required EditorState editorState,
  required String symbol,
}) async {
  assert(symbol == '[x]' || symbol == '-[x]');

  return formatMarkdownSymbol(
    editorState,
    (node) => node.type != 'todo_list',
    (text, _) => text == symbol,
    (_, node, delta) => Node(
      type: 'todo_list',
      attributes: {
        'checked': true,
        'delta': delta.compose(Delta()..delete(symbol.length)).toJson(),
      },
    ),
  );
}
