import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/features/whisps/presentation/blocs/profile/profile_bloc.dart';
import 'package:whisup/features/whisps/presentation/blocs/whisp_label/whisp_label_cubit.dart';
import 'package:whisup/features/whisps/presentation/blocs/whisps/whisps_bloc.dart';
import 'package:whisup/features/whisps/presentation/widgets/whisp/loaded/list.dart';
import 'package:whisup/features/whisps/presentation/widgets/whisp/loading/list.dart';
import 'package:whisup/features/whisps/presentation/widgets/whisp_field/whisp_field.dart';
import 'package:whisup/features/widgets/empty_list/empty_list.dart';
import 'package:whisup/features/widgets/preview_avatar/preview_avatar.dart';
import 'package:whisup/features/widgets/shimmer/shimmer.dart';
import 'package:whisup/features/widgets/text/text.dart';

class WhispsPage extends StatelessWidget {
  const WhispsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // initialization
    final controller = ScrollController();

    // bloc
    final bloc = BlocProvider.of<WhispsBloc>(context);

    // load list
    bloc.add(LoadWhisps());

    final textController = TextEditingController();

    void method(String value) {
      bloc.add(AddWhisp(message: value));
      textController.clear();
    }

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.greyBorder, width: 2),
                  ),
                ),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    Random random = Random();
                    Widget username = MyShimmer(
                      height: 14,
                      width: random.nextInt(96).toDouble(),
                    );
                    Widget avatar = CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.greyBorder,
                    );
                    Widget follower = Row(
                      children: [
                        Icon(Icons.people, size: 12),
                        SizedBox(width: 4),
                        MyShimmer(height: 14, width: 24),
                      ],
                    );
                    Widget relate = Row(
                      children: [
                        MyText(text: "Reaction", fontSize: 14),
                        SizedBox(width: 4),
                        MyShimmer(height: 14, width: 24),
                      ],
                    );
                    if (state is ProfileLoaded) {
                      avatar = PixelAvatarPreview(
                        pixels: state.pixelAvatar,
                        size: 32,
                      );
                      username = MyText(
                        text: "@${state.username}",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      );
      
                      follower = Row(
                        children: [
                          Icon(Icons.people_outline, size: 14),
                          SizedBox(width: 4),
                          MyText(
                            text: "20K",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      );
                      relate = Row(
                        children: [
                          MyText(text: "Reaction", fontSize: 12),
                          SizedBox(width: 4),
                          MyText(
                            text: "100K",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          avatar,
                          SizedBox(width: 8),
                          username,
                          Spacer(),
                          SizedBox(width: 8),
                          follower,
                          SizedBox(width: 8),
                          relate,
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<WhispsBloc, WhispsState>(
                  builder: (context, state) {
                    // initial or loading
                    if (state is WhispsInitial || state is WhispsLoading) {
                      return const MyWhispsLoading();
      
                      // loaded
                    } else if (state is WhispsLoaded) {
                      controller.addListener(() {
                        if (controller.position.maxScrollExtent ==
                                controller.offset &&
                            state.hasMore) {
                          bloc.add(LoadMoreWhisps());
                        }
                      });
      
                      // list loaded
                      if (state.listObject.isNotEmpty) {
                        return Column(
                          children: [
                            Expanded(
                              child: MyWhispsLoaded(
                                controller: controller,
                                listObject: state.listObject,
                                hasMore: state.hasMore,
                              ),
                            ),
                            BlocProvider(
                              create: (context) => WhispLabelCubit(),
                              child: WhispField(
                                controller: textController,
                                method: method,
                              ),
                            ),
                          ],
                        );
                      }
                      // list empty
                      else {
                        return const MyEmptyList(
                          icon: Icons.chat_bubble_outline,
                          title: "It's a little quiet here...",
                          subtitle:
                              "No whisps yet. Be the first to say something!",
                        );
                      }
      
                      // else or error
                    } else {
                      return const MyEmptyList(
                        icon: Icons.wifi_off,
                        title: 'Whoops! Something went wrong 😕',
                        subtitle: 'Please check your connection and try again.',
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
