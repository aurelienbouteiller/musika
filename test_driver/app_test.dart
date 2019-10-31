import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main(){
  group('Musika App', (){
    FlutterDriver driver;
    final loginTextFinder = find.byValueKey('login');

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('test login', () async {
      expect(await driver.getText(loginTextFinder), "LOGIN");
    });

  });
}