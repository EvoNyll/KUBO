// Mocks generated by Mockito 5.1.0 from annotations
// in kubo/test/features/food_planner/presentation/blocs/menu/menu_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:flutter/material.dart' as _i11;
import 'package:kubo/core/error/failures.dart' as _i6;
import 'package:kubo/core/helpers/date_converter.dart' as _i10;
import 'package:kubo/core/usecases/usecase.dart' as _i9;
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart'
    as _i7;
import 'package:kubo/features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i2;
import 'package:kubo/features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i4;
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedule_list.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeRecipeScheduleRepository_0 extends _i1.Fake
    implements _i2.RecipeScheduleRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [CreateRecipeSchedule].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreateRecipeSchedule extends _i1.Mock
    implements _i4.CreateRecipeSchedule {
  MockCreateRecipeSchedule() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RecipeScheduleRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue: _FakeRecipeScheduleRepository_0())
          as _i2.RecipeScheduleRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.RecipeSchedule>> call(
          _i4.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  Future<_i3.Either<_i6.Failure, _i7.RecipeSchedule>>.value(
                      _FakeEither_1<_i6.Failure, _i7.RecipeSchedule>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.RecipeSchedule>>);
}

/// A class which mocks [FetchRecipeScheduleList].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchRecipeScheduleList extends _i1.Mock
    implements _i8.FetchRecipeScheduleList {
  MockFetchRecipeScheduleList() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RecipeScheduleRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue: _FakeRecipeScheduleRepository_0())
          as _i2.RecipeScheduleRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.RecipeSchedule>>> call(
          _i9.NoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<
                      _i3.Either<_i6.Failure, List<_i7.RecipeSchedule>>>.value(
                  _FakeEither_1<_i6.Failure, List<_i7.RecipeSchedule>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.RecipeSchedule>>>);
}

/// A class which mocks [DateConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockDateConverter extends _i1.Mock implements _i10.DateConverter {
  MockDateConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Either<_i6.Failure, _i10.StartAndEndDateTime> convertStartAndEndTimeOfDay(
          {int? day,
          _i11.TimeOfDay? startTimeOfDay,
          _i11.TimeOfDay? endTimeOfDay}) =>
      (super.noSuchMethod(
              Invocation.method(#convertStartAndEndTimeOfDay, [], {
                #day: day,
                #startTimeOfDay: startTimeOfDay,
                #endTimeOfDay: endTimeOfDay
              }),
              returnValue:
                  _FakeEither_1<_i6.Failure, _i10.StartAndEndDateTime>())
          as _i3.Either<_i6.Failure, _i10.StartAndEndDateTime>);
}
