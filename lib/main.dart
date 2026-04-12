import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/api_service.dart';
import 'blocs/rooms_bloc/rooms_bloc.dart';
import 'blocs/booking_bloc/booking_bloc.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomsBloc>(create: (context) => RoomsBloc(ApiService())),
        BlocProvider<BookingBloc>(
          create: (context) => BookingBloc(ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Meeting Room Booking',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF0066FF),
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0066FF),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
