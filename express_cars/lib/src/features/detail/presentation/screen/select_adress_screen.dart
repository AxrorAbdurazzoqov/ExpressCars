import 'package:express_cars/src/core/common/custom_elevated_button.dart';
import 'package:express_cars/src/core/common/custom_search_field.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/features/detail/presentation/screen/payment_screen.dart';
import 'package:express_cars/src/features/detail/presentation/widget/custom_adress_radio_listile.dart';
import 'package:flutter/material.dart';

class SelectAdressScreen extends StatefulWidget {
  const SelectAdressScreen({super.key});

  @override
  State<SelectAdressScreen> createState() => SelectAdressScreenState();
}

class SelectAdressScreenState extends State<SelectAdressScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? location;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomSearchTextField(
                controller: _searchController,
              ),
            ),
            CustomAddressRadioListTile(
              groupValue: location,
              title: 'Home',
              address: '4140 Parker Rd. Allentown, New Mexico 31134',
              isSelected: true,
              image: 'https://developers.google.com/static/maps/images/landing/hero_maps_static_api.png',
            ),
            CustomAddressRadioListTile(
              groupValue: location,
              title: 'Work',
              address: '8502 Preston Rd. Inglewood, Maine 98380',
              isSelected: true,
              image: 'https://developers.google.com/static/maps/images/landing/hero_maps_static_api.png',
            ),
            CustomAddressRadioListTile(
              groupValue: location,
              title: 'Office',
              address: '6391 Elgin St. Celina, Delaware 10299',
              isSelected: true,
              image: 'https://developers.google.com/static/maps/images/landing/hero_maps_static_api.png',
            ),
            const Spacer(),
            CustomElevatedButton(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentScreen(),
                ),
              ),
              title: 'Confirm Address',
              fontSize: 16,
              height: context.getHeight(0.075),
              width: context.getWidth(1),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
