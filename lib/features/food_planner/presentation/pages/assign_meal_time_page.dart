import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/core/hive/objects/recipe_schedule_hive.dart';
import 'package:kubo/core/temp/recipe.dart';
import 'package:kubo/features/food_planner/data/datasources/recipe_schedule_local_data_source.dart';
import 'package:kubo/features/food_planner/presentation/widgets/assign_meal_time_form.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_clipper.dart';
import 'package:kubo/features/food_planner/presentation/widgets/screen_dark_effect.dart';

class AssignMealTimePageArguments {
  AssignMealTimePageArguments({
    required this.recipe,
  });

  Recipe recipe;
}

class AssignMealTimePage extends StatefulWidget {
  static const String id = 'assign_meal_time_page';

  const AssignMealTimePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final AssignMealTimePageArguments arguments;

  @override
  State<AssignMealTimePage> createState() => _AssignMealTimePageState();
}

class _AssignMealTimePageState extends State<AssignMealTimePage> {
  RecipeScheduleHive? recipeScheduleHive;

  Future<void> initializeBox() async {
    Box<RecipeScheduleHive> box = await Hive.openBox(kRecipeScheduleBoxKey);

    if (box.isEmpty == false) {
      final Recipe recipe = widget.arguments.recipe;

      recipeScheduleHive = box.get(recipe.id);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeBox();
  }

  @override
  Widget build(BuildContext context) {
    final Recipe recipe = widget.arguments.recipe;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const KuboTransparentAppBar('Assign Meal Time'),
      body: DirectSelectContainer(
        child: Stack(
          children: [
            Positioned.fill(
              //
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const ScreenDarkEffect(),
            const RecipeClipper(),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height / 2 + 50,
                width: size.width - 10,
                padding: const EdgeInsets.all(16.0),
                child: AssignMealTimeForm(
                  schedule: recipeScheduleHive,
                  recipe: recipe,
                ),
              ),
            ),
            Positioned(
              top: 65.0,
              left: 16,
              child: SizedBox(
                width: size.width - 40,
                child: Text(
                  recipe.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 85.0,
              left: 16,
              child: SizedBox(
                width: size.width - 40,
                child: Text(
                  recipeScheduleHive != null
                      ? _scheduleFormatter(recipeScheduleHive)
                      : 'No schedule',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _scheduleFormatter(RecipeScheduleHive? scheduleHive) {
    final todayWeekday = DateFormat('EEEE').format(scheduleHive!.start);

    return '$todayWeekday, ${_dateTimeToString(scheduleHive.start)} - ${_dateTimeToString(scheduleHive.end)}';
  }

  String? _dateTimeToString(DateTime? time) {
    if (time == null) {
      return null;
    }

    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(time);
  }
}
