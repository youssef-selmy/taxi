import 'package:api_response/api_response.dart';
import 'package:better_assets/assets.dart';
import 'package:better_design_showcase/core/components/table_footer.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

enum _WaitingListItemStatus { complete, waiting }

class _WaitingListItem {
  final String name;
  final String email;
  final String date;
  final String country;
  final AssetGenImage countryImage;
  final _WaitingListItemStatus status;

  _WaitingListItem({
    required this.name,
    required this.email,
    required this.date,
    required this.country,
    required this.countryImage,
    required this.status,
  });
}

class SalesAndMarketingWaitingListCard extends StatelessWidget {
  final bool isMobile;
  const SalesAndMarketingWaitingListCard({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final orders = [
      _WaitingListItem(
        name: 'Angel Gouse',
        email: 'AngelGouse@gmail.com',
        date: '21 Oct 2025',
        country: 'Spain',
        countryImage: Assets.images.countries.spain,
        status: _WaitingListItemStatus.complete,
      ),
      _WaitingListItem(
        name: 'Martin Calzoni',
        email: 'MartinCalzoni@gmail.com',
        date: '25 Jan 2025',
        country: 'Spain',
        countryImage: Assets.images.countries.spain,
        status: _WaitingListItemStatus.waiting,
      ),
      _WaitingListItem(
        name: 'Marcus Bergson',
        email: 'MarcusBergson@gmail.com',
        date: '05 Oct 2025',
        country: 'Denmark',
        countryImage: Assets.images.countries.denmark,
        status: _WaitingListItemStatus.complete,
      ),
      _WaitingListItem(
        name: 'Abram Bator',
        email: 'AbramBator@gmail.com',
        date: '08 Oct 2025',
        country: 'Norway',
        countryImage: Assets.images.countries.norway,
        status: _WaitingListItemStatus.waiting,
      ),
      _WaitingListItem(
        name: 'Alfonso Lipshutz',
        email: 'AlfonsoLipshutz@gmail.com',
        date: '11 Sep 2025',
        country: 'France',
        countryImage: Assets.images.countries.france,
        status: _WaitingListItemStatus.complete,
      ),
    ];

    final data = ApiResponse<List<_WaitingListItem>>.loaded(orders);

    return isMobile ? _buildCards(context, orders) : _buildTable(context, data);
  }

  Widget _buildCards(BuildContext context, List<_WaitingListItem> orders) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Waiting List', style: context.textTheme.titleSmall),
            AppTextButton(
              size: ButtonSize.medium,
              onPressed: () {},
              text: 'See all',
              suffixIcon: BetterIcons.arrowRight02Outline,
              color: SemanticColor.primary,
            ),
          ],
        ),
        SizedBox(height: 16),

        Column(
          spacing: 8,
          children: List.generate(orders.length, (index) {
            final item = orders[index];
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colors.surface,
                border: Border.all(color: context.colors.outline),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                spacing: 12,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8,
                    children: <Widget>[
                      Text(
                        item.date,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),

                      _buildCountry(
                        context,
                        image: item.countryImage,
                        name: item.country,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildAvatar(
                        context,
                        avatarUrl: ImageFaker().person.images[index],
                        name: item.name,
                        email: item.email,
                      ),

                      _buildStatus(item.status),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTable(
    BuildContext context,
    ApiResponse<List<_WaitingListItem>> data,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Waiting List', style: context.textTheme.titleSmall),
                Row(
                  children: [
                    SizedBox(
                      width: 270,
                      child: AppTextField(
                        density: TextFieldDensity.noDense,
                        hint: 'Search',
                        isFilled: false,
                        prefixIcon: Icon(
                          BetterIcons.search01Filled,
                          color: context.colors.onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    AppOutlinedButton(
                      onPressed: () {},
                      text: 'Filter',
                      prefixIcon: BetterIcons.filterVerticalOutline,
                      size: ButtonSize.medium,
                      color: SemanticColor.neutral,
                    ),
                    SizedBox(width: 12),
                    AppOutlinedButton(
                      onPressed: () {},
                      text: 'Filter',
                      prefixIcon: BetterIcons.sorting01Outline,
                      size: ButtonSize.medium,
                      color: SemanticColor.neutral,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppDivider(height: 20),
          SizedBox(height: 16),
          SizedBox(
            height: 400,
            child: AppDataTable<List<_WaitingListItem>, dynamic>(
              minWidth: 1400,
              data: data,
              getPageInfo:
                  (_) => OffsetPageInfo(
                    hasNextPage: false,
                    hasPreviousPage: false,
                  ),

              getRowCount: (list) => list.length,
              onPageChanged: (_) {},
              paging: OffsetPaging(limit: 10, offset: 0),
              columns: [
                DataColumn2(fixedWidth: 60, label: AppCheckbox(value: false)),
                DataColumn2(
                  fixedWidth: 220,
                  label: Row(
                    children: [
                      Text('Name', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
                      _buildSortIcon(context),
                    ],
                  ),
                ),
                DataColumn2(
                  fixedWidth: 240,
                  label: Row(
                    children: [
                      Text('Email', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
                      _buildSortIcon(context),
                    ],
                  ),
                ),
                DataColumn2(
                  fixedWidth: 160,
                  label: Row(
                    children: [
                      Text('Date Added', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
                      _buildSortIcon(context),
                    ],
                  ),
                ),

                DataColumn2(
                  fixedWidth: 180,
                  label: Row(
                    children: [
                      Text('Country', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
                      _buildSortIcon(context),
                    ],
                  ),
                ),
                DataColumn2(
                  fixedWidth: 150,
                  label: Row(
                    children: [
                      Text('Status', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
                      _buildSortIcon(context),
                    ],
                  ),
                ),
                DataColumn2(fixedWidth: 90, label: Text('')),
              ],
              rowBuilder: (list, index) {
                final item = list[index];
                return DataRow(
                  onSelectChanged: (_) {},
                  cells: [
                    DataCell(AppCheckbox(value: false)),
                    DataCell(
                      _buildAvatar(
                        context,
                        avatarUrl: ImageFaker().person.images[index],
                        name: item.name,
                      ),
                    ),
                    DataCell(
                      Text(item.email, style: context.textTheme.labelLarge),
                    ),
                    DataCell(
                      Text(item.date, style: context.textTheme.labelLarge),
                    ),
                    DataCell(
                      _buildCountry(
                        context,
                        image: item.countryImage,
                        name: item.country,
                      ),
                    ),
                    DataCell(_buildStatus(item.status)),
                    DataCell(
                      AppIconButton(
                        icon: BetterIcons.moreVerticalCircle01Outline,
                        isCircular: true,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          AppTableFooter(),
        ],
      ),
    );
  }

  Widget _buildSortIcon(BuildContext context) {
    return Icon(
      BetterIcons.unfoldMoreFilled,
      color: context.colors.onSurfaceVariantLow,
      size: 20,
    );
  }

  Widget _buildAvatar(
    BuildContext context, {
    required String avatarUrl,
    required String name,
    String? email,
  }) {
    return Row(
      spacing: 8,
      children: [
        AppAvatar(imageUrl: avatarUrl, size: AvatarSize.size40px),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(name, style: context.textTheme.labelLarge),
            if (email != null)
              Text(email, style: context.textTheme.bodySmall?.variant(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildCountry(
    BuildContext context, {
    required AssetGenImage image,
    required String name,
  }) {
    return Row(
      spacing: 8,
      children: [
        image.image(width: 24, height: 24),
        Text(name, style: context.textTheme.labelLarge),
      ],
    );
  }

  Widget _buildStatus(_WaitingListItemStatus status) {
    return AppTag(
      text: switch (status) {
        _WaitingListItemStatus.complete => 'Complete',
        _WaitingListItemStatus.waiting => 'Waiting',
      },
      color: switch (status) {
        _WaitingListItemStatus.complete => SemanticColor.success,
        _WaitingListItemStatus.waiting => SemanticColor.warning,
      },
    );
  }
}
