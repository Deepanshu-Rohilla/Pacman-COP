import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cpp/cpp.dart';

void main() {
  const MethodChannel channel = MethodChannel('cpp');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Cpp.platformVersion, '42');
  });
}
