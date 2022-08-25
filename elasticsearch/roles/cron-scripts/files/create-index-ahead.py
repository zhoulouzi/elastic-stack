#!/usr/bin/python3

import argparse
import time
import datetime
from elasticsearch import Elasticsearch


class myes():

    tocreatelist = []
    limits = 0
    interval = 0

    def __init__(self, username, password, endpoint, limits, interval):
        self.es = Elasticsearch(['http://{0}:{1}@{2}'.format(username,password,endpoint)])
        self.limits = limits
        self.interval = interval

    def do(self):
        self.fetch_indices()
        self.filter_indices(self.tocreatelist)
        self.create_index(self.tocreatelist)

    def fetch_indices(self):
        now_daytime = datetime.date.today()
        now_daytime_str = now_daytime.strftime('%Y.%m.%d')
        yesterday_daytime = now_daytime - datetime.timedelta(days=1)
        yesterday_daytime_str = yesterday_daytime.strftime('%Y.%m.%d')

        for name in self.es.cat.indices(index='*-{0}'.format(yesterday_daytime_str),format='json', h='index'):
            self.tocreatelist.append(name['index'].replace(yesterday_daytime_str, now_daytime_str))

    def filter_indices(self, indices):
        pass

    def create_index(self, indices):
        count = 0
        for i in indices:
            if count < self.limits:
                result = self.es.indices.create(index=i, request_timeout=30, ignore=400)
                print(datetime.datetime.now(), result)
                count += 1
                time.sleep(self.interval)
            else:
                break


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='This script is for quickly creating index ahead in any elasicsearch cluster.')

    group1 = parser.add_argument_group('elasic')
    group1.add_argument('-u', help='elasticsearch username', required=True)
    group1.add_argument('-p', help='elasticsearch password', required=True)
    parser.add_argument('-e', help='elasticsearch cluster endpoints', required=True)
    parser.add_argument('-l', help='limits number for index to be created', default=1, type=int)
    parser.add_argument('-i', help='interval between index create action', default=10, type=int)


    args = parser.parse_args()

    instance = myes(args.u,args.p,args.e, args.l, args.i)
    instance.do()
