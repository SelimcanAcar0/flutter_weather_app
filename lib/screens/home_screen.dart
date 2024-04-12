import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weather_app/bloc/weather_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF673AB7),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFAB40),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is WeatherSuccess) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLocationText(
                            state.weather.areaName ?? 'Area Name Not Found',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          buildMessageText(state.weather.date!),
                          buildWeatherImage(
                            state.weather.weatherConditionCode!,
                          ),
                          buildCelsiusText(
                            state.weather.temperature!.celsius!.round(),
                          ),
                          buildWeatherText(
                            state.weather.weatherMain ?? 'No Data',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          buildDateText(state.weather.date!),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildSunriseRow(state.weather.sunrise!),
                              buildSunsetRow(state.weather.sunset!),
                            ],
                          ),
                          buildDivide(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildTempMaxRow(
                                state.weather.tempMax!.celsius!.round(),
                              ),
                              buildTempMinRow(
                                state.weather.tempMin!.celsius!.round(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Image buildWeatherImage(int weatherConditionCode) {
    final firstDigitString = weatherConditionCode.toString()[0];
    print(firstDigitString);
    final firstDigit = int.parse(firstDigitString);

    switch (firstDigit) {
      case 2:
        return Image.asset('assets/1.png');
      case 3:
        return Image.asset('assets/2.png');
      case 4:
        return Image.asset('assets/3.png');
      case 5:
        return Image.asset('assets/4.png');
      case 6:
        return Image.asset('assets/5.png');
      case 7:
        return Image.asset('assets/6.png');
      case 8:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }

  Padding buildDivide() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Divider(
        color: Colors.grey,
      ),
    );
  }

  Row buildTempMaxRow(int maxTemp) {
    return Row(
      children: [
        Image.asset(
          'assets/13.png',
          scale: 8,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Temp Max',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              '$maxTemp°C',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row buildTempMinRow(int minTemp) {
    return Row(
      children: [
        Image.asset(
          'assets/14.png',
          scale: 8,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Temp Min',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              '$minTemp°C',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row buildSunriseRow(DateTime dateTime) {
    final date = DateFormat().add_jm().format(dateTime);
    return Row(
      children: [
        Image.asset(
          'assets/11.png',
          scale: 8,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Sunrise',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              date,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row buildSunsetRow(DateTime dateTime) {
    final date = DateFormat().add_jm().format(dateTime);
    return Row(
      children: [
        Image.asset(
          'assets/12.png',
          scale: 8,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sunset',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              date,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Text buildMessageText(DateTime dateTime) {
    final hour = DateFormat('HH').format(dateTime);
    var message = '';
    print('Hour: $hour');
    switch (int.parse(hour)) {
      case > 5 && < 12:
        message = 'Good Morning';
      case > 12 && < 16:
        message = 'Good Afternoon';
      case > 16 && < 22:
        message = 'Good Evening';
      default:
        message = 'Good Night';
    }
    return Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text buildLocationText(String locationText) {
    return Text(
      '📍$locationText'.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Center buildDateText(DateTime dateTime) {
    final date = DateFormat('EEEE dd .').add_jm().format(dateTime);
    return Center(
      child: Text(
        date,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Center buildWeatherText(String weatherText) {
    return Center(
      child: Text(
        weatherText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Center buildCelsiusText(int temperature) {
    return Center(
      child: Text(
        '$temperature°C',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 55,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
