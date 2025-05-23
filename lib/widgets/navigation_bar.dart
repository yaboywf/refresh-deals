import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBar extends StatefulWidget {
  final String accountType;
  final int currentIndex;

  const NavBar({super.key, this.accountType = 'buyer', this.currentIndex = 0});

  @override
  State<NavBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavBar> {
  static const buyerNavData = [
    {'icon': FontAwesomeIcons.house, 'label': 'Home', 'route': '/buyer_home'},
    {
      'icon': FontAwesomeIcons.cartShopping,
      'label': 'Shop',
      'route': '/buyer_shop',
    },
    {
      'icon': FontAwesomeIcons.solidUser,
      'label': 'Profile',
      'route': '/profile',
    },
  ];

  static const sellerNavData = [
    {'icon': FontAwesomeIcons.house, 'label': 'Home', 'route': '/shop_home'},
    {'icon': FontAwesomeIcons.boxesStacked, 'label': 'Inventory'},
    {
      'icon': FontAwesomeIcons.solidUser,
      'label': 'Profile',
      'route': '/profile',
      "args": "accountType=shop",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final navData = widget.accountType == 'buyer' ? buyerNavData : sellerNavData;

    return BottomNavigationBar(
      backgroundColor: Colors.grey.shade200,
      currentIndex: widget.currentIndex,
      onTap: (index) {
        Navigator.pushReplacementNamed(
          context,
          navData[index]['route'] as String,
          arguments: navData[index].containsKey('args')
            ? {(navData[index]['args'] as String).split('=')[0]: (navData[index]['args'] as String).split('=')[1]}
            : null,
        );
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: List.generate(navData.length, (index) {
        final item = navData[index];
        final bool isSelected = index == widget.currentIndex;

        return BottomNavigationBarItem(
          label: '',
          icon: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration:
                isSelected
                    ? BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    )
                    : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(item['icon'] as IconData, size: 20, color: Colors.black),
                const SizedBox(height: 4),
                Text(
                  item['label'] as String,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
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
                FaIcon(item['icon'] as IconData, size: 24, color: Colors.black),
                const SizedBox(height: 4),
                Text(
                  item['label'] as String,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
