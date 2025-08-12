import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/features/whisps/data/model/whisp.dart';
import 'package:whisup/features/whisps/presentation/blocs/whisps/whisps_bloc.dart';
import 'package:whisup/features/whisps/presentation/widgets/whisp/loaded/item.dart';
import 'package:whisup/features/widgets/text/text.dart';

class MyWhispsLoaded extends StatelessWidget {
  final ScrollController controller;
  final List<CardWhispModel> listObject;
  final bool hasMore;

  const MyWhispsLoaded({
    required this.controller,
    required this.listObject,
    required this.hasMore,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<WhispsBloc>(context).add(RefreshWhisps());
      },
      child: Scrollbar(
        controller: controller,
        child: ListView.builder(
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: listObject.length + 1,
          itemBuilder: (context, index) {
            if (index < listObject.length) {
              return MyWhispItemLoaded(object: listObject[index]);
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 48),
                child: Center(
                  child:
                      hasMore
                          ? Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greyBackgrounReaction,
                            ),
                            child: const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          )
                          : const MyText(
                            text: "No more Whisps around… yet 👀",
                            fontSize: 12,
                            color: AppColors.greyText2,
                          ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
