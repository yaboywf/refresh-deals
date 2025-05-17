import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBar extends StatefulWidget {
  final String accountType;

  const NavBar({super.key, this.accountType = 'buyer'});

  @override
  State<NavBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavBar> {
  int _currentIndex = 0;

  static const buyerNavData = [
    {'icon': FontAwesomeIcons.house, 'label': 'Home'},
    {'icon': FontAwesomeIcons.cartShopping, 'label': 'Shop'},
    {'icon': FontAwesomeIcons.solidUser, 'label': 'Profile'},
  ];

  static const sellerNavData = [
    {'icon': FontAwesomeIcons.house, 'label': 'Home'},
    {'icon': FontAwesomeIcons.magnifyingGlass, 'label': 'Shop'},
    {'icon': FontAwesomeIcons.solidUser, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    final navData = widget.accountType == 'buyer' ? buyerNavData : sellerNavData;

    return BottomNavigationBar(
      backgroundColor: Colors.grey.shade200,
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: List.generate(navData.length, (index) {
        final item = navData[index];
        final bool isSelected = index == _currentIndex;

        return BottomNavigationBarItem(
          label: '',
          icon: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: isSelected ? BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ) : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  item['icon'] as IconData,
                  size: 20,
                  color: Colors.black,
                ),
                const SizedBox(height: 4),
                Text(
                  item['label'] as String,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                ),
              ],
            )
          ),
          activeIcon: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  item['icon'] as IconData,
                  size: 24,
                  color: Colors.black,
                ),
                const SizedBox(height: 4),
                Text(
                  item['label'] as String,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ),
        );
      }),
    );
  }
}
