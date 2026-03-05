import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:admin_frontend/core/graphql/documents/firebase.graphql.dart';
import 'package:admin_frontend/core/repositories/firebase_repository.dart';

@prod
@LazySingleton(as: FirebaseRepository)
class FirebaseRepositoryImpl implements FirebaseRepository {
  final GraphqlDatasource _graphqlDatasource;

  FirebaseRepositoryImpl(this._graphqlDatasource);

  @override
  Future<void> retrieveAndUpdateFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus != AuthorizationStatus.denied) {
      final token = await messaging.getToken(
        vapidKey: dotenv.maybeGet('FIREBASE_MESSAGING_VAPID_KEY') ?? "",
      );
      if (token != null) {
        await _graphqlDatasource.mutate(
          Options$Mutation$UpdateFcmToken(
            variables: Variables$Mutation$UpdateFcmToken(fcmToken: token),
          ),
        );
      }
    }
  }
}
