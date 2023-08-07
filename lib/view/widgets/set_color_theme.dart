import 'package:flutter/material.dart';
import 'package:music_player/data/model/color_theme/color_theme.dart';
import 'package:music_player/resources/app_strings.dart';
import 'package:music_player/resources/size_manager.dart';

class SetColorTheme extends StatelessWidget {
  final List<ColorTheme> colors;
  final ColorTheme colorSelected;
  final void Function(ColorTheme color)? onSelect;

  const SetColorTheme({
    super.key,
    required this.colors,
    required this.colorSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const ListTile(
          leading: Icon(Icons.color_lens_outlined),
          title: Text(AppStrings.titleListTileChangeTheme),
        ),
        Container(
          padding: const EdgeInsets.only(left: AppPadding.p14),
          height: AppSize.s42,
          child: ListView.builder(
            itemCount: colors.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              ColorTheme color = colors[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s90),
                  border: colorSelected.color.contains(color.color)
                      ? Border.all(
                          width: AppSize.s2,
                          color: Theme.of(context).focusColor,
                        )
                      : const Border(),
                ),
                child: InkWell(
                  onTap: () => onSelect!(color),
                  borderRadius: BorderRadius.circular(AppSize.s90),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p2),
                    child: Container(
                      width: AppSize.s56,
                      decoration: BoxDecoration(
                        color: Color(color.parseColor),
                        borderRadius: BorderRadius.circular(AppSize.s90),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
