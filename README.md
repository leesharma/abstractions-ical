# Abstractions iCal

A quick script to grab the Abstractions schedule from their API and convert it to iCal format.

**Update:** Abstractions iCal is now a server. See the [text output] or [subscribe]!
Want your own server? Deploy one instantly using the heroku deploy button below.

[text output]: https://abstractions-ical.herokuapp.com/
[subscribe]: https://abstractions-ical.herokuapp.com/abstractions.ics

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

**Quick Links:** [Abstractions API] | [Schedule Endpoint] | [Main Webpage]

[Abstractions API]: http://abstractions.io/api/
[Schedule Endpoint]: http://abstractions.io/api/schedule.json
[Main Webpage]: http://abstractions.io/

## How to Use

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
