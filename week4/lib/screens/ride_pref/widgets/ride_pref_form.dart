import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import '../../../utils/date_time_util.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/inputs/bla_location_picker.dart';
import 'ride_pref_input_tile.dart';

class RidePrefForm extends StatefulWidget {
  const RidePrefForm({super.key, required this.initialPreference, required this.onSubmit});

  final RidePreference? initialPreference;
  final Function(RidePreference preference) onSubmit;

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  @override
  void initState() {
    super.initState();

    if (widget.initialPreference != null) {
      RidePreference current = widget.initialPreference!;
      departure = current.departure;
      arrival = current.arrival;
      departureDate = current.departureDate;
      requestedSeats = current.requestedSeats;
    } else {
      departure = null;
      departureDate = DateTime.now();
      arrival = null;
      requestedSeats = 1;
    }
  }

  void onDeparturePressed() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(BlaLocationPicker(initLocation: departure)),
    );

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(BlaLocationPicker(initLocation: arrival)),
    );

    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  /// Shows a date picker to select departure date
void onDatePressed() async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: departureDate,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)), // Allow selection up to a year ahead
  );

  if (selectedDate != null) {
    setState(() {
      departureDate = selectedDate;
    });
  }
}
  /// Shows a number picker for seat selection
  void onSeatsPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Select Number of Seats", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: requestedSeats > 1
                        ? () => setState(() => requestedSeats--)
                        : null,
                  ),
                  Text(requestedSeats.toString(), style: const TextStyle(fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: requestedSeats < 10
                        ? () => setState(() => requestedSeats++)
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Done"),
              ),
            ],
          ),
        );
      },
    );
  }

  void onSubmit() {
    if (departure != null && arrival != null) {
      RidePreference newPreference = RidePreference(
        departure: departure!,
        departureDate: departureDate,
        arrival: arrival!,
        requestedSeats: requestedSeats,
      );

      widget.onSubmit(newPreference);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              RidePrefInputTile(
                isPlaceHolder: departure == null,
                title: departure?.name ?? "Leaving from",
                leftIcon: Icons.location_on,
                onPressed: onDeparturePressed,
              ),
              const BlaDivider(),
              RidePrefInputTile(
                isPlaceHolder: arrival == null,
                title: arrival?.name ?? "Going to",
                leftIcon: Icons.location_on,
                onPressed: onArrivalPressed,
              ),
              const BlaDivider(),
              RidePrefInputTile(
  title: DateTimeUtils.formatDateTime(departureDate),
  leftIcon: Icons.calendar_month,
  onPressed: onDatePressed,
),
              const BlaDivider(),
              RidePrefInputTile(
                title: "$requestedSeats Seat${requestedSeats > 1 ? 's' : ''}",
                leftIcon: Icons.person,
                onPressed: onSeatsPressed,
              ),
            ],
          ),
        ),
        BlaButton(text: 'Search', onPressed: onSubmit),
      ],
    );
  }
}
