class ConvertedCode {
  String widgetCode;
  String className;

  ConvertedCode(this.widgetCode, this.className);
}

class CodeConverter {
  ConvertedCode convertCode(String widgetCode, String modelCode) {
    final lines = widgetCode.split('\n');
    final outputLines = <String>[];
    var className = '';
    var modelName = '';
    var addModelLinesNext = false;
    var inDispose = false;

    var modelInfo = parseModel(modelCode);
    modelName = modelInfo['name'];

    var removeLines = [
      "import '/flutter_flow/flutter_flow_util.dart';",
      "import '/flutter_flow/flutter_flow_theme.dart';",
      "import 'package:google_fonts/google_fonts.dart';",
      "import 'package:provider/provider.dart';",
      "import 'home_page_model.dart';",
      "export 'home_page_model.dart';",
      "late $modelName _model;",
      "_model = createModel(context, () => $modelName());",
      "_model.dispose();",
    ];

    for (var line in lines) {
      /*
      if (line.contains('final')) {
        final parts = line.split(' ');
        final type = parts[1];
        final name = parts[2].substring(0, parts[2].length - 1);
        final value = parts[4].substring(0, parts[4].length - 1);

        final outputLine = '$type $name = $inputModel.$value;';
      }
      */

      // Remove some lines
      if (removeLines.contains(line.trim())) {
        continue;
      }

      if (line.contains('Validator') || line.contains('unfocusNode')) {
        continue;
      }

      // Find the name of the class so we can use it later
      if (className == '') {
        if (line.trim().contains(RegExp('class (.*) extends'))) {
          final parts = line.split(' ');
          className = parts[1];
        }
      }

      line = line.replaceFirst('_model.', '');
      line = line.replaceFirst('FlutterFlowTheme', "${className}Theme");
      line = line.replaceFirst('.override', "?.copyWith");

      outputLines.add(line);

      // If we're in the dispose method, we want to add the model dispose code
      if (line.contains('void dispose')) {
        outputLines.add(modelInfo['dispose']);
      }

      // If we see the GlobalKey line, we can add the model lines
      if (line.contains('GlobalKey')) {
        outputLines.add(modelInfo['varLines']);
      }
    }

    outputLines.add(themeClassCode(className));

    final output = outputLines.join('\n');

    return ConvertedCode(output, '$className.dart');
  }

  Map parseModel(String modelCode) {
    if (modelCode == '') {
      return {
        'varLines': '',
        'dispose': '',
        'name': '',
      };
    }

    final lines = modelCode.split('\n');
    final varLines = <String>[];
    final disposeLines = <String>[];
    var modelName = '';
    var inDispose = false;

    var removeLines = [
      "final unfocusNode = FocusNode();",
      "unfocusNode.dispose();",
      "void initState(BuildContext context) {}",
    ];

    for (var line in lines) {
      line = line.trim();

      // Remove some lines
      if (removeLines.contains(line)) {
        continue;
      }

      // If we don't have a model name yet, just continue until we find it
      if (modelName == '') {
        if (line.contains(RegExp('class (.*) extends'))) {
          final parts = line.split(' ');
          modelName = parts[1];
        }
      } else {
        // Once we have a model name, we want to add most of the lines until we
        // get to the dispose method
        if (line.contains('void dispose')) {
          inDispose = true;
          continue;
        }
        // So if we're not in the dispose method yet (above check), we want to
        // add the line to the varLines
        if (!inDispose) {
          if (line.startsWith('//') ||
              line.contains('Validator') ||
              line.isEmpty) {
            continue;
          }

          varLines.add(line);
        } else {
          // If we are in the dispose method, we want to add the line to the
          // disposeLines until we get to the end of the method, then we're done
          // with the model
          if (line == '}') {
            break;
          }
          disposeLines.add(line);
        }
      }
    }

    return {
      'varLines': varLines.join('\n'),
      'dispose': disposeLines.join('\n'),
      'name': modelName,
    };
  }

  String themeClassCode(String className) {
    return '''
class ${className}Theme {
  BuildContext context;

  ${className}Theme(this.context);

  static ${className}Theme of(BuildContext context) {
    return ${className}Theme(context);
  }

  Color get primary => Theme.of(context).colorScheme.primary;
  Color get primaryBackground => Theme.of(context).colorScheme.background;
  TextStyle? get headlineMedium => Theme.of(context).textTheme.headlineMedium;
  TextStyle? get bodyMedium => Theme.of(context).textTheme.bodyMedium;
  TextStyle? get labelMedium => Theme.of(context).textTheme.labelMedium;
  Color get alternate => Theme.of(context).colorScheme.secondary;
  Color get error => Theme.of(context).colorScheme.error;
}
''';
  }
}
