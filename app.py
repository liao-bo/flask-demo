#!flask/bin/python
from flask import Flask, jsonify, abort, request
import datetime
import socket

NTP_hostname = socket.gethostname()

app = Flask(__name__)

datecenter_timezone ={'SH': 'UTC+8',
                      'NY': 'UTC-5',
                      'SYZ': 'UTC+10'

}

web_time = {'UTC_time': '',
            'UTC_formad': "%Y-%m-%dT%H:%M:%S.%fZ",
            'NTP_server': NTP_hostname
            }

local_time = {'hostname': '',
              'timezone': '',
              'localtime':'',
              'local_formad': "%Y-%m-%dT%H:%M:%S.%fZ"
              }

def utc_time():
    utc_st = datetime.datetime.utcnow()
    return utc_st


def utc_format(date):
    format_utc_st = datetime.datetime.strftime(date, web_time['UTC_formad'])
    web_time['UTC_time'] = format_utc_st
    return web_time


@app.route('/')
def index():
    return "This is a demo for kubernete micservice"


@app.route('/app/api/v1.0/UTC', methods=['GET'])
def app_utc():
    web_time = utc_format(utc_time())
    return jsonify({'UTC_now': web_time})


@app.route('/app/api/v1.0/timezone', methods=['POST'])
def local_timezone():
    if not request.json or not 'hostname' in request.json :
        abort(400)
    else:
        hostname = request.json['hostname']
        dc_name = hostname.split('-')[0].upper()
        if dc_name not in datecenter_timezone:
            abort(400)
        utc_st = utc_time()
        web_time = utc_format(utc_st)
        timezone = datecenter_timezone[dc_name]
        hour_delay = timezone.split('UTC')[1]
        time_st = utc_st + datetime.timedelta(hours=int(hour_delay))
        format_time = datetime.datetime.strftime(time_st, local_time['local_formad'])
        local_time['hostname'] = hostname
        local_time['timezone'] = timezone
        local_time['localtime'] = format_time
        result = {'time_now':local_time,
                  'NTP_info': web_time
                  }
        return jsonify(result)


if __name__ == '__main__':
    app.run(host = '0.0.0.0',
        debug=True)
