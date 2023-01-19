### this should run as a sub process in our main app 
### it will listen for changes and update the ENV Variable that the FRONT END will expose

import os
import time
import consul
from asyncio import subprocess
import threading
import time
import subprocess

consul_client = consul.Consul(
    host='localhost',
    port=8500,
)

exitFlag = 0
index = None
data = None
class myThread (threading.Thread):
   def __init__(self, threadID, name, counter, destroy):
      threading.Thread.__init__(self )
      self.threadID = threadID
      self.name = name
      self.counter = counter
      self.destroy = destroy

   def run(self):
      print ("Starting " + self.name)
      pull_kv(self.name, self.counter, self.destroy)
      # print ("Exiting " + self.name)

def print_time(threadName, delay, counter):
   while counter:
      if exitFlag:
         threadName.exit()
      time.sleep(delay)
      print ("%s: %s" % (threadName, time.ctime(time.time())))
      counter -= 1


def newtherads(x ,y , destroy):
   #  x = rangevalue

    for i in range(x,y):

      # Create new threads
      i = myThread(1, "Thread-%s" % (i) , i, destroy)
      # thread2 = myThread(2, "Thread-2", 1)

      # Start new Threads
      if destroy == "true":
         time.sleep(6)
         i.start()
      else:
         i.start()
      # thread2.start()
      # i.join() # This will cause the threads to wait for the previous to complete
      #thread2.join()
      print ("Exiting Main Thread $i")



def pull_kv(threadName, counter, destroy):
   arg = str(counter)
   if exitFlag:
      threadName.exit()

   print ("%s: %s" % (threadName, time.ctime(time.time())))
   time.sleep(2)
   subprocess.run([run_kv(None), arg,threadName])
   #time.sleep(delay)
   # print ("%s: %s" % (threadName, time.ctime(time.time())))
   # counter -= 1


def run_kv(index):
    while True:
        index, data = consul_client.kv.get('application/BOOKS/NAME', index=index)
        print (data['Value'])
        os.environ["VALUE"] = str(data['Value'])



#subprocess.run(pull_kv(None), capture_output=True)
newtherads(0,1, "false")
#subprocess.run(pull_kv(None),stdout=PIPE, stderr=PIPE)
time.sleep(10)
print(os.environ["VALUE"])