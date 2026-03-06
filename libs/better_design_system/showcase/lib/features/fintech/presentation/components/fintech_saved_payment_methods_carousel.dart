import 'package:better_design_showcase/core/components/page_indicator.dart';
import 'package:flutter/material.dart';

import 'fintech_saved_payment_method_card.dart';

class FintechSavedPaymentMethodsCarousel extends StatefulWidget {
  const FintechSavedPaymentMethodsCarousel({super.key});

  @override
  State<FintechSavedPaymentMethodsCarousel> createState() =>
      _FintechSavedPaymentMethodsCarouselState();
}

class _FintechSavedPaymentMethodsCarouselState
    extends State<FintechSavedPaymentMethodsCarousel> {
  final _cards = [
    FintechSavedPaymentMethodCard(
      cardSubtitle: 'Niklaus Mikaelson',
      displayValue: '**** **** **** 7788',
      expireDate: '01/02',
      style: SavedPaymentMethodStyle.gradientRed,
      type: SavedPaymentMethodType.cardNumber,
    ),
    FintechSavedPaymentMethodCard(
      cardSubtitle: 'Elijah Mikaelson',
      displayValue: '**** **** **** 1122',
      expireDate: '05/27',
      style: SavedPaymentMethodStyle.gradientBlue,
      type: SavedPaymentMethodType.cardNumber,
    ),
    FintechSavedPaymentMethodCard(
      cardSubtitle: 'Niklaus Bank',
      displayValue: '**** **** **** 3344',
      expireDate: '09/25',
      style: SavedPaymentMethodStyle.gradientPurple,
      type: SavedPaymentMethodType.cardNumber,
    ),
  ];
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            padEnds: true,
            pageSnapping: true,
            controller: _pageController,
            itemCount: _cards.length,
            itemBuilder: (context, index) {
              return AnimatedPadding(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.zero,
                child: Row(children: [Expanded(child: _cards[index])]),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        AppPageIndicator(pageCount: _cards.length, currentPage: _currentPage),
      ],
    );
  }
}
