import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/features/create_profile/presentation/blocs/pixel_avatar/pixel_avatar_bloc.dart';
import 'package:whisup/features/widgets/button/bottom_button.dart';
import 'package:whisup/features/widgets/text/text.dart';

class CreateAvatarPage extends StatelessWidget {
  const CreateAvatarPage({super.key});

  static const int gridSize = 7;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final pixelSize = screenWidth / gridSize;
    void onSaveAvatar() {
      void onSuccess() {
        context.goNamed("main");
      }

      context.read<PixelAvatarBloc>().add(
        PixelAvatarSave(onSuccess: onSuccess),
      );
    }

    void onColorSelected(color) {
      context.read<PixelAvatarBloc>().add(PixelAvatarColorChanged(color));
    }

    void onResetAvatar() {
      context.read<PixelAvatarBloc>().add(PixelAvatarReset());
    }

    void onTogglePixel(int x, int y) {
      context.read<PixelAvatarBloc>().add(PixelAvatarPixelToggled(x: x, y: y));
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<PixelAvatarBloc, PixelAvatarState>(
                builder: (context, state) {
                  final coloredPixels =
                      state is PixelAvatarLoaded ? state.coloredPixels : {};
                  final selectedColor =
                      state is PixelAvatarLoaded
                          ? state.selectedColor
                          : Colors.black;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        text: "Create Your Avatar",
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 8),
                      MyText(
                        text:
                            "Customize your avatar by choosing colors and filling the grid. Have fun drawing!",
                        fontSize: 12,
                        color: AppColors.greyText2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      // Drawing Grid
                      Center(
                        child: Container(
                          width: screenWidth,
                          height: screenWidth,
                          color: Colors.grey[300],
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: gridSize,
                                ),
                            itemCount: gridSize * gridSize,
                            itemBuilder: (context, index) {
                              final x = index % gridSize;
                              final y = index ~/ gridSize;
                              final key = '${x}_$y';
                              final color = coloredPixels[key];

                              return GestureDetector(
                                onTap: () => onTogglePixel(x, y),
                                child: Container(
                                  margin: const EdgeInsets.all(0.5),
                                  color: color ?? Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Color Picker
                      _ColorPicker(
                        selectedColor: selectedColor,
                        onColorSelected: onColorSelected,
                      ),
                    ],
                  );
                },
              ),
            ),
            MyBottomButton(onPressed: onSaveAvatar, labelText: "Save Avatar"),
          ],
        ),
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  final List<Color> palette = const [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.brown,
    Colors.pink,
  ];

  final Color selectedColor;
  final void Function(Color) onColorSelected;

  const _ColorPicker({
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: palette.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final color = palette[index];
          return GestureDetector(
            onTap: () => onColorSelected(color),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      selectedColor == color
                          ? Colors.black
                          : Colors.grey.shade400,
                  width: 2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
