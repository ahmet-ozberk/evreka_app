import 'package:evreka_app/app/constant/characters.dart';
import 'package:evreka_app/app/constant/constants.dart';
import 'package:evreka_app/app/extension/num_extension.dart';
import 'package:evreka_app/app/extension/widget_extension.dart';
import 'package:evreka_app/ui/components/buttons/app_button.dart';
import 'package:evreka_app/ui/views/google_map/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContainerInfoWidget extends ConsumerWidget {
  const ContainerInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.read(mapProvider);
    final watch = ref.watch(mapProvider);
    if (watch.activeContainer == null) return const SizedBox.shrink();
    final model = watch.activeContainer!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0XFFFBFCFF),
        boxShadow: const [
          BoxShadow(
            color: Color(0XFFBBBBBB),
            offset: Offset(0, 0),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (watch.isChangeMarker) ...[
            Text(Constants.string.changeMarkerLocationInfo,
                style: CharacterStyles.t1),
            15.height,
            SizedBox(
              width: double.maxFinite,
              child: AppButton(
                text: "SAVE",
                onPressed: () async {
                  read.saveLocation();
                },
              ),
            )
          ] else ...[
            Text("Container ${(model.containerId ?? '').substring(0, 7)}",
                style: CharacterStyles.h3),
            5.height,
            Text("Next Collection", style: CharacterStyles.h4),
            Text(getFormattedDate(model.date ?? ""), style: CharacterStyles.t1),
            5.height,
            Text("Fullness Rate", style: CharacterStyles.h4),
            Text("%${model.percentage ?? ""}", style: CharacterStyles.t1),
            13.height,
            Row(
              children: [
                AppButton(onPressed: () {}, text: "NAVIGATE").expanded,
                22.width,
                AppButton(
                  onPressed: () async {
                    await read.clearMarkers();
                  },
                  text: "RELOCATE",
                ).expanded,
              ],
            )
          ],
        ],
      ),
    );
  }

  String getFormattedDate(String date) {
    final dateTime = DateTime.parse(date);
    final day = dateTime.day.toString().padLeft(2, "0");
    final month = dateTime.month.toString().padLeft(2, "0");
    final year = dateTime.year;
    return "$day.$month.$year";
  }
}
