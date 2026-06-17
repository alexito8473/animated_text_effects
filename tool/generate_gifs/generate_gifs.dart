import 'dart:io';
import 'package:image/image.dart' as img;

const maxWidth = 600;
const gifDelay = 15;

String _basename(String path) {
  return path.split(Platform.pathSeparator).last;
}

void main(List<String> args) async {
  final rootDir = Directory.current.parent.parent;
  final exampleDir = Directory('${rootDir.path}/example');
  final screenshotDir = Directory('${rootDir.path}/doc/screenshots');
  screenshotDir.createSync(recursive: true);

  final scenarioDirs = exampleDir
      .listSync()
      .whereType<Directory>()
      .where((d) => File('${d.path}/frame_000.png').existsSync())
      .toList()
    ..sort((a, b) => _basename(a.path).compareTo(_basename(b.path)));

  if (scenarioDirs.isEmpty) {
    print('No frame directories found in example/');
    exit(1);
  }

  for (final frameDir in scenarioDirs) {
    final scenarioName = _basename(frameDir.path);

    final frameFiles = frameDir
        .listSync()
        .whereType<File>()
        .where((f) {
          final name = _basename(f.path);
          return name.startsWith('frame_') && name.endsWith('.png');
        })
        .toList()
      ..sort((a, b) => _basename(a.path).compareTo(_basename(b.path)));

    if (frameFiles.isEmpty) continue;

    print('Generating $scenarioName.gif from ${frameFiles.length} frames...');

    final frames = <img.Image>[];
    for (final file in frameFiles) {
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image != null) {
        final resized = image.width > maxWidth
            ? img.copyResize(image, width: maxWidth)
            : image;
        frames.add(resized);
      }
    }

    if (frames.isEmpty) continue;

    final encoder = img.GifEncoder(repeat: 0, delay: gifDelay);
    for (final frame in frames) {
      encoder.addFrame(frame);
    }
    final gif = encoder.finish();
    final outputPath = '${screenshotDir.path}/$scenarioName.gif';
    await File(outputPath).writeAsBytes(gif!);
    print('  -> ${(gif.length / 1024).toStringAsFixed(1)} KB');
  }

  print('Done!');
}
