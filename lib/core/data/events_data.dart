import 'package:aad/core/models/event_model.dart';

/// Events and conferences data
class EventsData {
  EventsData._();

  static final List<EventModel> events = [
    EventModel(
      id: 'gdg_izmir_devfest',
      nameKey: 'event_gdg_izmir_devfest',
      organizer: 'GDG Izmir',
      date: DateTime(2024, 11),
      location: 'Izmir, Turkey',
    ),
    EventModel(
      id: 'wtm_izmir',
      nameKey: 'event_wtm_izmir',
      organizer: 'Women Techmakers Izmir',
      date: DateTime(2024, 3),
      location: 'Izmir, Turkey',
    ),
    EventModel(
      id: 'gdg_manisa_devfest',
      nameKey: 'event_gdg_manisa_devfest',
      organizer: 'GDG Manisa',
      date: DateTime(2024, 10),
      location: 'Manisa, Turkey',
    ),
    EventModel(
      id: 'dsc_galatasaray_flutter',
      nameKey: 'event_dsc_galatasaray_flutter',
      organizer: 'Google DSC Galatasaray',
      date: DateTime(2023, 6),
      location: 'Istanbul, Turkey',
    ),
    EventModel(
      id: 'google_io_extended_izmir',
      nameKey: 'event_google_io_extended_izmir',
      organizer: 'Google I/O Extended Izmir',
      date: DateTime(2024, 5),
      location: 'Izmir, Turkey',
    ),
    EventModel(
      id: 'fuckup_nights_izmir',
      nameKey: 'event_fuckup_nights_izmir',
      organizer: 'Fuck Up Nights Izmir',
      date: DateTime(2024, 4),
      location: 'Izmir, Turkey',
    ),
    EventModel(
      id: 'cloud_jam_a_thon',
      nameKey: 'event_cloud_jam_a_thon',
      organizer: 'Cloud Jam a Thon',
      date: DateTime(2023, 11),
      location: 'Online',
    ),
    EventModel(
      id: 'hack_n_break',
      nameKey: 'event_hack_n_break',
      organizer: 'Hack\'N Break',
      date: DateTime(2024, 2),
      location: 'Izmir, Turkey',
    ),
    EventModel(
      id: 'create_in_izmir',
      nameKey: 'event_create_in_izmir',
      organizer: 'Create In Izmir',
      date: DateTime(2024, 9),
      location: 'Izmir, Turkey',
    ),
  ];
}

