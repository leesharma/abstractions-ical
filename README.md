# Abstractions iCal (Script + Server)

A quick script to grab the Abstractions schedule from their API and convert it to iCal format.

**Update:** Abstractions iCal is now a server. See the [text output] or [subscribe]!
Want your own server? Deploy one instantly using the heroku deploy button below.

[text output]: https://abstractions-ical.herokuapp.com/
[subscribe]: https://abstractions-ical.herokuapp.com/abstractions.ics

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

**Quick Links:** [Abstractions iCal] | [Abstractions API] | [Schedule Endpoint] | [Main Webpage]

[Abstractions iCal]: https://abstractions-ical.herokuapp.com/abstractions.ics
[Abstractions API]: http://abstractions.io/api/
[Schedule Endpoint]: http://abstractions.io/api/schedule.json
[Main Webpage]: http://abstractions.io/

## How to Use

### Subscribe

Subscribe using the url https://abstractions-ical.herokuapp.com/abstractions.ics

Here are directions for a few popular vendors:

- [OS X (iCloud)](https://support.apple.com/en-us/HT202361)
- [iOS](http://www.imore.com/how-subscribe-calendars-your-iphone-or-ipad)
- [Google](https://support.google.com/calendar/answer/37100?hl=en)
- [Outlook](https://support.office.com/en-us/article/View-and-subscribe-to-Internet-Calendars-f6248506-e144-4508-b658-c838b6067597)

### Generate a Schedule

Clone and navigate into the repository. Then, install dependencies:

```bash
$ bundle install
```

You can either output the iCal to console with:

```bash
$ bin/ical
```

Or you can save it to a file in the `out` folder with:

```bash
$ bin/download_ical
```

Enter your desired filename when prompted (sans extension or path, ex. `abstractions.1.0` to get `out/abstractions.1.0.ics`) and press Enter.

You'll find your output in `out/<filename>.ics`.

## TODO

- [ ] Cache API responses so I don't hit the endpoint ∞ times
- [ ] Cache the iCal until the API response changes

## License

[MIT](LICENSE)
