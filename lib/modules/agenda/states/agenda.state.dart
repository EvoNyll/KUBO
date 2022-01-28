import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/modules/agenda/bloc/agenda_cubit.dart';
import 'package:kubo/widgets/buttons/icon.button.dart';
import 'package:kubo/widgets/clippers/appbar.clipper.dart';

class AgendaState extends StatefulWidget {
  const AgendaState({Key? key}) : super(key: key);

  @override
  _AgendaStateState createState() => _AgendaStateState();
}

class _AgendaStateState extends State<AgendaState> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgendaCubit, AgendaCubitState>(
      builder: (context, state) => Column(
        children: <Widget>[
          const CustomAppBar(
            title: "Agenda",
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: state.agendas.length,
                itemBuilder: (context, index) {
                  var agenda = state.agendas[index];
                  return Card(
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                agenda.name,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                const Icon(
                                  Icons.access_alarm_sharp,
                                  size: 18,
                                ),
                                Text(agenda.deadline),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          splashColor: kBrownPrimary,
                          onPressed: () => BlocProvider.of<AgendaCubit>(context)
                              .removeTask(agenda),
                          icon: const Icon(
                            Icons.delete,
                            color: kBrownPrimary,
                            size: 30,
                          ))
                    ]),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: <Widget>[
          const AppbarClipper(color: kGreenPrimary),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CostumeIconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: kGreenPrimary,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Arvo Bold',
                  ),
                ),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
