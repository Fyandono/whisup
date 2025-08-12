import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/features/create_profile/presentation/blocs/create_username/create_username_bloc.dart';
import 'package:whisup/features/create_profile/presentation/widgets/field/text_field.dart';
import 'package:whisup/features/widgets/button/bottom_button.dart';
import 'package:whisup/features/widgets/text/text.dart';

class CreateUsernamePage extends StatelessWidget {
  const CreateUsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    void onChangedUsername(value) {
      if (value != null) {
        BlocProvider.of<CreateUsernameBloc>(
          context,
        ).add(UpdateUsername(value: value));
      }
    }

    void onTapStartWhisup() {
      void onSuccess() {
        context.goNamed("avatar");
      }

      BlocProvider.of<CreateUsernameBloc>(
        context,
      ).add(CreateUsernamePost(onSuccess: onSuccess));
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "Pick Your Username",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8),
                  MyText(
                    text:
                        "This username is just for you — and for this device only. You won't be able to change it later, so make it count 😉",
                    fontSize: 12,
                    color: AppColors.greyText2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  BlocBuilder<CreateUsernameBloc, CreateUsernameState>(
                    builder: (context, state) {
                      return MyTextField(
                        enabled: state is! CreateUsernamePosting,
                        label: "Username",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        onChanged: onChangedUsername,
                        inputFormatters: [LowerCaseTextFormatter()],
                        inputAction: TextInputAction.send,
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  BlocBuilder<CreateUsernameBloc, CreateUsernameState>(
                    builder: (context, state) {
                      if (state is CreateUsernameChecking) {
                        return MyText(text: "Checking...", fontSize: 12);
                      } else if (state is CreateUsernameLooksGood) {
                        return MyText(text: "Looks good on you ✅", fontSize: 12);
                      } else if (state is CreateUsernameAlreadyTaken) {
                        return MyText(
                          text: "Oops, that one’s taken 😞",
                          fontSize: 12,
                        );
                      } else if (state is CreateUsernameNotValid) {
                        return MyText(
                          text: "Use 5+ letters, numbers, or _ only 😎",
                          fontSize: 12,
                        );
                      } else {
                        return MyText(
                          text:
                              "Username can be anything … just keep it anonymous 👀",
                          fontSize: 12,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),
          ),
          BlocBuilder<CreateUsernameBloc, CreateUsernameState>(
            builder: (context, state) {
              if (state is CreateUsernameLooksGood ||
                  state is CreateUsernameErrorPosting) {
                return MyBottomButton(
                  onPressed: onTapStartWhisup,
                  labelText: "Start Whisup",
                );
              } else {
                return MyBottomButton(
                  onPressed: null,
                  labelText: "Start Whisup",
                  isLoading: state is CreateUsernamePosting,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
