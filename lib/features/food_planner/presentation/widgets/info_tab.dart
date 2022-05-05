import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:pod_player/pod_player.dart';

class InfoTab extends StatefulWidget {
  const InfoTab({
    Key? key,
    required this.recipe,
    // required this.player,
  }) : super(key: key);

  final Recipe recipe;
  // final YoutubePlayer player;

  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab>
    with AutomaticKeepAliveClientMixin<InfoTab> {
  late PodPlayerController _podController;

  @override
  void initState() {
    _podController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/BIarUjm4U-0'))
      ..initialise();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _podController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        shrinkWrap: true,
        children: [
          PodVideoPlayer(controller: _podController),
          const SizedBox(height: 16.0),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 8.0,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(width: 5.0, color: kGreenPrimary),
              ),
            ),
            child: Text(
              widget.recipe.name,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '\t\t\t\t${widget.recipe.description}',
              style: const TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
