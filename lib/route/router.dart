import 'package:go_router/go_router.dart';
import '../core/models/model.dart';
import '../core/services/navigation.dart';
import '../pages/app/store/view/store_view_page.dart';
import '../pages/app/store_page.dart';
import '../pages/error/error_page.dart';
import '../pages/init/init_page.dart';
import 'path.dart';

class Routers {
  static String get init => 'init';

  static String get store => 'store';

  static String get storeApp => 'storeApp';

  static final GoRouter _router = GoRouter(
    initialLocation: RouterPaths.init,
    navigatorKey: Navigation.navigationKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: init,
        path: RouterPaths.init,
        builder: (context, state) => const InitPage(),
      ),
      GoRoute(
          name: store,
          path: RouterPaths.store,
          builder: (context, state) {
            final Map<String, dynamic> extra =
                GoRouterState.of(context).extra! as Map<String, dynamic>;
            return StorePage(extra: extra);
          }),
      GoRoute(
        name: storeApp,
        path: RouterPaths.storeApp,
        builder: (context, state) {
          final App app = GoRouterState.of(context).extra! as App;
          return StoreViewPage(app: app);
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(state.error!),
  );

  GoRouter get router => _router;
}
