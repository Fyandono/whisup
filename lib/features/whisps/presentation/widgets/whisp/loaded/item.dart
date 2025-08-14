import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/features/whisps/data/model/whisp.dart';
import 'package:whisup/features/whisps/presentation/blocs/react/react_bloc.dart';
import 'package:whisup/features/widgets/highlight_text/highlight_text.dart';
import 'package:whisup/features/widgets/preview_avatar/preview_avatar.dart';
import 'package:whisup/features/widgets/text/text.dart';
import 'package:whisup/util/emoticon_count_cubit.dart';

class MyWhispItemLoaded extends StatelessWidget {
  const MyWhispItemLoaded({required this.object, super.key});

  final CardWhispModel object;

  @override
  Widget build(BuildContext context) {
    // void onTap(int id, String emoji, EmoticonCountCubit cubit) {
    //   // Send to server (ignore response handling here)
    //   context.read<ReactBloc>().add(ReactComment(id: id, comment: emoji));
    // }

    String formatTimestamp(String isoString) {
      try {
        final date = DateTime.parse(isoString).toLocal();
        return DateFormat('MMM d, HH:mm').format(date);
      } catch (_) {
        return '';
      }
    }

    return BlocProvider(
      create:
          (_) => EmoticonCountCubit({
            for (var r in object.reactions) r.keys.first: r.values.first,
          }),
      child: BlocBuilder<EmoticonCountCubit, EmoticonCountState>(
        builder: (context, state) {
          final cubit = context.read<EmoticonCountCubit>();

          return Container(
            key: Key(object.id.toString()),
            margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.greyBorder.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  children: [
                    PixelAvatarPreview(pixels: object.avatar, size: 24),
                    SizedBox(width: 6),
                    Expanded(
                      child: MyText(
                        text: "@${object.username}",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyText,
                      ),
                    ),
                    SizedBox(width: 4),
                    MyText(
                      text: formatTimestamp(object.createdAt),
                      fontSize: 11,
                      color: AppColors.greyText2,
                    ),
                    SizedBox(width: 6),
                    MyHighlightText(
                      text: object.nearOrPublic,
                      fontColor: object.fontColor,
                      backgroundColor: object.backgroundColor,
                      borderColor: object.borderColor,
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                /// Message
                MyText(
                  text: object.message,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 12),

                /// Reactions
                if (state.counts.isNotEmpty)
                  Wrap(
                    spacing: 12,
                    children:
                        state.counts.entries.map((entry) {
                          final emoji = entry.key;
                          final count = entry.value;
                          final isSelected = state.selectedEmoji == emoji;

                          return InkWell(
                            onTap: () {
                              cubit.react(emoji);
                              context.read<ReactBloc>().add(
                                ReactComment(id: object.id, comment: emoji),
                              );
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Colors.blue.withValues(alpha: 0.2)
                                        : AppColors.greyBackgrounReaction,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MyText(text: emoji, fontSize: 14),
                                  const SizedBox(width: 4),
                                  MyText(text: count.toString(), fontSize: 12),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
