import 'package:country_code_picker/src/model/country.dart';
import 'package:country_code_picker/src/model/country_list.dart';

/// Property name to use in filter
const String property = 'alpha_2_code';

/// [CountryProvider] provides helper classes that involves manipulations.
/// of Countries from [Countries.countries]
class CountryProvider {
  /// Get data of Countries.
  ///
  /// Returns List of [Country].
  ///
  ///  * If [countries] is `null` or empty it returns a list of
  ///  all [Countries.countries].
  ///  * If [countries] is not empty it returns a filtered list containing
  ///    counties as specified.
  static List<Country> getCountriesData({List<String>? countries}) {
    final jsonList = Countries.countries;

    if (countries == null || countries.isEmpty) {
      return jsonList.map(Country.fromJson).toList();
    }
    final filteredList = jsonList.where((country) {
      return countries.contains(country[property]);
    }).toList();

    return filteredList.map(Country.fromJson).toList();
  }
}
