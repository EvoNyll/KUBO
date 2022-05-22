import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/detected_categories_dialog.dart';

class PredictedImageInfo extends StatelessWidget {
  const PredictedImageInfo({
    Key? key,
    required this.predictedImage,
    this.saveScannedIngredients,
    required this.close,
    required this.isNetworkImage,
  }) : super(key: key);

  final PredictedImage predictedImage;

  final VoidCallback? saveScannedIngredients;
  final VoidCallback close;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final categoriesWithQuantity =
        Utils.fixRepeatingCategories(predictedImage.categories);

    final saveScannedIngredientsFinal = saveScannedIngredients;

    return Stack(
      fit: StackFit.expand,
      children: [
        isNetworkImage == true
            ? Image.network(
                predictedImage.imageUrl,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              )
            : Image.file(
                File(predictedImage.imageUrl),
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
        ClipRRect(
          // Clip it cleanly.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.2),
              alignment: Alignment.center,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top + 55,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesWithQuantity.length,
                  padding: const EdgeInsets.only(
                    left: 30.0,
                  ),
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: kBboxColorClass[
                              categoriesWithQuantity[index].category.name],
                          radius: 6.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${categoriesWithQuantity[index].quantity.toString()} ${categoriesWithQuantity[index].category.name}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Montserrat Medium',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: isNetworkImage == true
                    ? Image.network(
                        predictedImage.imageUrl,
                        alignment: Alignment.center,
                        loadingBuilder: (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      )
                    : Image.file(
                        File(
                          predictedImage.imageUrl,
                        ),
                        alignment: Alignment.center,
                      ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: MediaQuery.of(context).viewPadding.top + 5,
          child: Row(
            children: [
              if (predictedImage.categories.isNotEmpty)
                RoundedButton(
                  icon: const Icon(Icons.restaurant),
                  title: const Text(
                    'Show accuracy table of results',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => DetectedCategoriesDialog(
                        categories: predictedImage.categories,
                      ),
                    );
                  },
                ),
              ElevatedButton(
                onPressed: close,
                child: const Icon(Icons.close, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(2.0),
                  primary: kBrownPrimary,
                ),
              ),
            ],
          ),
        ),
        predictedImage.categories.isNotEmpty &&
                saveScannedIngredientsFinal != null
            ? Positioned(
                bottom: 16,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: RoundedButton(
                    icon: const Icon(Icons.save),
                    title: const Text(
                      'Save as scanned ingredients',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    onPressed: saveScannedIngredientsFinal,
                  ),
                ),
              )
            : Positioned(
                bottom: 16,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: RoundedButton(
                    title: const Text(
                      'No ingredients scanned, Please try again.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        CameraPage.id,
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
