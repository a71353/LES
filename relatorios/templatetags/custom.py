from django import template
import datetime

register = template.Library()

@register.filter
def parse_timestamp(filename):
    # Extract the timestamp part from the filename, assuming it's always formatted as shown.
    try:
        # The timestamp starts at 28th position to the end, minus the extension (.pdf)
        timestamp_str = filename[28:-4]
        # Parse the timestamp assuming it's in "YYYYMMDDHHMMSS" format
        timestamp = datetime.datetime.strptime(timestamp_str, "%Y%m%d%H%M%S")
        # Return the formatted date-time string
        return timestamp.strftime("%d/%m/%Y %H:%M")
    except ValueError:
        return "Invalid date"