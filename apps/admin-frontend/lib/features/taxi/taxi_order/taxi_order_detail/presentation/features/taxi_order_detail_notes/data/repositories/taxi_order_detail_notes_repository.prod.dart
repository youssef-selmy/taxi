import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_notes/data/graphql/taxi_order_detail_notes.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_notes/data/repositories/taxi_order_detail_notes_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: TaxiOrderDetailNotesRepository)
class TaxiOrderDetailNotesRepositoryImpl
    implements TaxiOrderDetailNotesRepository {
  final GraphqlDatasource graphQLDatasource;

  TaxiOrderDetailNotesRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$taxiOrderNotes>> getTaxiOrderNotes({
    required String orderId,
  }) async {
    final getTaxiOrderNotes = await graphQLDatasource.query(
      Options$Query$taxiOrderNotes(
        variables: Variables$Query$taxiOrderNotes(orderId: orderId),
      ),
    );
    return getTaxiOrderNotes;
  }

  @override
  Future<ApiResponse<Fragment$taxiOrderNote>> createTaxiOrderNote({
    required Input$CreateTaxiOrderNoteInput input,
  }) async {
    final createTaxiOrderNote = await graphQLDatasource.mutate(
      Options$Mutation$crateTaxiOrderNote(
        variables: Variables$Mutation$crateTaxiOrderNote(input: input),
      ),
    );
    return createTaxiOrderNote.mapData((f) => f.createTaxiOrderNote);
  }
}
