import 'package:country_code_picker/src/model/country.dart';
import 'package:flutter/material.dart';

/// [Item]
class Item extends StatelessWidget {
  /// Constructor
  const Item({
    super.key,
    required this.country,
    required this.onPressed,
  });

  /// Country data model
  final Country country;

  /// On Pressed function
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Image.asset(
        country.flagUri,
        width: 32,
        package: 'country_code_picker',
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox.shrink();
        },
      ),
      title: Text(
        country.name ?? '',
        textDirection: TextDirection.ltr,
        //style: const TextStyle(fontSize: 15),
      ),
      trailing: Text(country.dialCode ?? ''),
    );
  }
}
