part of 'weather_bloc.dart';

@immutable
sealed class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherFailure extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  const WeatherSuccess(this.weather);
  final Weather weather;

  @override
  List<Object> get props => [weather];
}
