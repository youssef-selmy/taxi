import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension PageInfoX on Fragment$OffsetPageInfo {
  OffsetPageInfo get pageInfo => OffsetPageInfo(
    hasNextPage: hasNextPage,
    hasPreviousPage: hasPreviousPage,
  );

  Fragment$PageInfo get nextPage => Fragment$PageInfo(
    hasNextPage: hasNextPage ?? true,
    hasPreviousPage: hasPreviousPage ?? true,
  );
}

extension PageInfoXX on Fragment$PageInfo {
  Fragment$OffsetPageInfo get offsetPageInfo => Fragment$OffsetPageInfo(
    hasNextPage: hasNextPage,
    hasPreviousPage: hasPreviousPage,
  );
}

extension OffsetPagingX on Input$OffsetPaging {
  OffsetPaging get offsetPaging => OffsetPaging(limit: limit, offset: offset);

  Input$PaginationInput get toPaginationInput =>
      Input$PaginationInput(first: limit, after: offset);
}

extension OffsetPagingXX on Input$PaginationInput {
  OffsetPaging get offsetPaging => OffsetPaging(limit: first, offset: after);

  Input$OffsetPaging get toOffsetPaging =>
      Input$OffsetPaging(limit: first, offset: after);
}

extension PageChangedFnX on dynamic Function(Input$OffsetPaging) {
  void Function(OffsetPaging) get pageChangedFn =>
      (page) =>
          call(Input$OffsetPaging(limit: page.limit, offset: page.offset));
}
