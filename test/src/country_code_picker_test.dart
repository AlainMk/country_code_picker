// ignore_for_file: prefer_const_constructors
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountryCodePicker', () {
    test('can be instantiated', () {
      expect(
        CountryCodePicker(
          onSelected: (v) {},
        ),
        isNotNull,
      );
    });
  });
}
