import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  const Ingredient({
    required this.name,
    required this.quantity,
  });

  final String name;
  final int quantity;
  @override
  List<Object?> get props => [
        name,
        quantity,
      ];
}
