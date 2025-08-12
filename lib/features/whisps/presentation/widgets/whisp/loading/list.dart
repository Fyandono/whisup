import 'package:flutter/material.dart';
import 'package:whisup/features/whisps/presentation/widgets/whisp/loading/item.dart';

class MyWhispsLoading extends StatelessWidget {
  const MyWhispsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return MyWhispItemLoading();
      },
    );
  }
}
