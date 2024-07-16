import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

export 'package:provider/provider.dart';
import '../repositories/api_repository.dart';
import '../repositories/db_repository.dart';
import '../services/api.dart';
import '../services/db.dart';
import 'global_provider.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider<Api>.value(value: Api()),
  Provider<DB>.value(value: DB.instance),
  ChangeNotifierProvider<GlobalProvider>(
      create: (_) => GlobalProvider(
          apiRepository: ApiRepository(api: Api()),
          dbRepository: DBRepository(db: DB.instance))),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, ApiRepository>(
      update: (context, api, apiRepository) => ApiRepository(api: api)),
  ProxyProvider<DB, DBRepository>(
      update: (context, db, dbRepository) => DBRepository(db: db)),
];

List<SingleChildWidget> uiConsumableProviders = [];
