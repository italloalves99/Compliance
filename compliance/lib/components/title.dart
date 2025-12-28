import 'package:compliance/theme/app_assets.dart';
import 'package:compliance/theme/app_colors.dart';
import 'package:compliance/theme/text_style.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return  Text(
                      AppAssets.nome_empresa,
                      style: AppTextStyle.body.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.verdeOliva,
                        letterSpacing: 0.5,
                      ),
                    );
  }
}