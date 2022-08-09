import 'package:country_code_picker/src/model/country.dart';
import 'package:country_code_picker/src/provider/country_provider.dart';
import 'package:country_code_picker/src/util/util.dart';
import 'package:country_code_picker/src/widgets/item.dart';
import 'package:flutter/material.dart';

/// {@template country_code_picker}
/// Country code picker module

class CountryCodePicker extends StatelessWidget {
  /// Default constructor
  const CountryCodePicker({super.key, required this.onSelected});

  /// Retrieving selected country after pressed
  final Function(Country) onSelected;
  @override
  Widget build(BuildContext context) {
    final countries = CountryProvider.getCountriesData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Select Country'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final country = countries[index];
          return Item(
            country: country,
            onPressed: () {
              onSelected(country);
              Navigator.pop(context);
            },
          );
        },
        itemCount: countries.length,
      ),
    );
  }
}

/// Widget that show flag and dial number
class FlagWidget extends StatefulWidget {
  /// Constructor
  const FlagWidget({
    super.key,
    required this.builder,
    this.initialCountry,
    this.flagWidth,
    this.marginLeft,
    this.marginRight,
    this.textColor,
  });

  /// Builder method that return selected country
  final Function(Country) builder;

  /// Initial country if passed
  final String? initialCountry;

  /// Flag with (optional)
  final double? flagWidth;

  /// Margin start (optional)
  final double? marginLeft;

  /// Margin end (optional)
  final double? marginRight;

  /// text color (optional)
  final Color? textColor;

  @override
  State<FlagWidget> createState() => _FlagWidgetState();
}

class _FlagWidgetState extends State<FlagWidget> {
  Country? selectedCountry;
  final countries = CountryProvider.getCountriesData();
  @override
  Widget build(BuildContext context) {
    final country = selectedCountry ??
        Utils.getInitialSelectedCountry(
          countries,
          widget.initialCountry ?? 'us',
        );
    return Container(
      margin: EdgeInsets.only(
        left: widget.marginLeft ?? 8,
        right: widget.marginRight ?? 0,
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push<MaterialPageRoute>(
            context,
            MaterialPageRoute(
              builder: (builder) {
                return CountryCodePicker(
                  onSelected: (country) {
                    setState(() {
                      selectedCountry = country;
                      widget.builder(country);
                    });
                  },
                );
              },
            ),
          );
        },
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              country.flagUri,
              width: widget.flagWidth ?? 30,
              package: 'country_code_picker',
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              selectedCountry != null
                  ? '${selectedCountry?.dialCode}'
                  : '${country.dialCode}',
              style: TextStyle(color: widget.textColor ?? Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
