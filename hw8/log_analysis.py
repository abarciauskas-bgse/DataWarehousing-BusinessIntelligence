from mrjob.job import MRJob

# python log_analysis.py NASA_access_log_Jul95
class MRWordFrequencyCount(MRJob):
  def mapper(self, _, line):
    values = line.split()
    if len(values) > 5:
      host = values[0]
      page = values[6]
      yield (host, 1)
      yield (page, 1)

  def reducer(self, key, values):
    yield key, sum(values)

if __name__ == '__main__':
  MRWordFrequencyCount.run()
