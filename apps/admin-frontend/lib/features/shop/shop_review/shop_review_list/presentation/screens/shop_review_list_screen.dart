import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/presentation/blocs/shop_review_list.cubit.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/presentation/components/shop_review_list_table.dart';

@RoutePage()
class ShopReviewListScreen extends StatelessWidget {
  const ShopReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopReviewListBloc()..onStarted(),
      child: BlocBuilder<ShopReviewListBloc, ShopReviewListState>(
        builder: (context, state) {
          return PageContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(
                  title: context.tr.feedbacks,
                  subtitle: context.tr.listOfUserFeedbacks,
                ),
                const SizedBox(height: 16),
                const Expanded(child: ShopReviewListTable()),
              ],
            ),
          );
        },
      ),
    );
  }
}
