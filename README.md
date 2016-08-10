# Abstractions iCal

A quick script to grab the Abstractions schedule from their API and convert it to iCal format.

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

## License

[MIT](LICENSE)
