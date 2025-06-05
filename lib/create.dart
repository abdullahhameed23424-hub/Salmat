import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('❌ Please provide a base folder name.');
    return;
  }

  final inputName = arguments[0].replaceAll('\\', '/'); // cross-platform
  final segments = inputName.split('/');
  final baseName = segments.last; // e.g., "product"
  final className = _toPascalCase(baseName); // e.g., "Product"

  final structure = {
    '$inputName/view/screens': () {
      final file = File('$inputName/view/screens/${baseName}_screen.dart');
      if (!file.existsSync()) {
        file.writeAsStringSync('''
import 'package:flutter/material.dart';

class ${className}Screen extends StatelessWidget {
  const ${className}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Container(),
    );
  }
}
''');
        print('📄 Created: ${file.path}');
      }
    },
    '$inputName/view/widgets': null,
    '$inputName/models': null,
    '$inputName/cubit': () {
      final cubitFile = File('$inputName/cubit/${baseName}_cubit.dart');
      final stateFile = File('$inputName/cubit/${baseName}_state.dart');

      // Write cubit file
      if (!cubitFile.existsSync()) {
        cubitFile.writeAsStringSync('''
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part '${baseName}_state.dart';

class ${className}Cubit extends Cubit<${className}State> {
  ${className}Cubit() : super(${className}Initial());
}
''');
        print('📄 Created: ${cubitFile.path}');
      }

      // Write state file
      if (!stateFile.existsSync()) {
        stateFile.writeAsStringSync('''
part of '${baseName}_cubit.dart';

@immutable
sealed class ${className}State {}

final class ${className}Initial extends ${className}State {}

final class ${className}LoadingState extends ${className}State {}

final class ${className}SuccessState extends ${className}State {}

final class ${className}ErrorState extends ${className}State {
  final String message;

  ${className}ErrorState({required this.message});
}
''');
        print('📄 Created: ${stateFile.path}');
      }
    }
  };

  // Create folders and run any custom file generators
  structure.forEach((path, fileCreator) {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      print('✅ Created: $path');
    } else {
      print('⚠️ Already exists: $path');
    }

    if (fileCreator != null) {
      fileCreator();
    }
  });
}

/// Converts snake_case or kebab-case to PascalCase
String _toPascalCase(String text) {
  return text
      .split(RegExp(r'[_\-]'))
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join();
}
