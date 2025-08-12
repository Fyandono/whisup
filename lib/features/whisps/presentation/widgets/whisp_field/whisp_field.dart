import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/features/whisps/presentation/blocs/whisp_label/whisp_label_cubit.dart';

class WhispField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) method;

  const WhispField({required this.controller, required this.method, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyBorder,
            blurRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: 40,
              color: AppColors.greyBackgrounReaction,
              // child:
              // BackdropFilter(
              // filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BlocBuilder<WhispLabelCubit, String>(
                      builder: (context, hint) {
                        return TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: hint,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            isDense: true,
                          ),
                          style: const TextStyle(
                            color: AppColors.greyText2,
                            fontSize: 14,
                          ),
                          onSubmitted: method,
                          textInputAction: TextInputAction.send,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.send,
                        color: AppColors.blueIcon,
                        size: 20,
                      ),
                    ),
                  ),
                ],
                // ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
