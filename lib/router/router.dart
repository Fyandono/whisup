import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whisup/features/create_profile/presentation/blocs/create_username/create_username_bloc.dart';
import 'package:whisup/features/create_profile/presentation/blocs/pixel_avatar/pixel_avatar_bloc.dart';
import 'package:whisup/features/create_profile/presentation/page/create_avatar.dart';
import 'package:whisup/features/create_profile/presentation/page/create_username.dart';
import 'package:whisup/features/whisps/presentation/blocs/post/post_feed_bloc.dart';
import 'package:whisup/features/whisps/presentation/blocs/profile/profile_bloc.dart';
import 'package:whisup/features/whisps/presentation/blocs/whisps/whisps_bloc.dart';
import 'package:whisup/features/whisps/presentation/page/whisp.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter myRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      name: '/',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => CreateUsernameBloc(),
          child: const CreateUsernamePage(),
        );
      },
      routes: [
        GoRoute(
          name: 'avatar',
          path: 'avatar',
          builder: (BuildContext context, GoRouterState state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (context) => PixelAvatarBloc()..add(PixelAvatarStarted()),
                ),
              ],
              child: const CreateAvatarPage(),
            );
          },
        ),

        // main page
        GoRoute(
          name: 'main',
          path: 'main',
          builder: (BuildContext context, GoRouterState state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProfileBloc()..add(LoadProfile()),
                ),
                BlocProvider(
                  create: (context) => WhispsBloc()..add(LoadWhisps()),
                ),
                BlocProvider(create: (context) => PostFeedBloc()),
              ],
              child: const WhispsPage(),
            );
          },
        ),
      ],
    ),
  ],
);
