module Lib
  ( someFunc,
  )
where

import BankSim
  ( Colour,
    blue,
    getArrivalTime,
    getAvgMaxStats,
    getQueueLengthList,
    getServiceTime,
    getWaitingTime,
    red,
    toTimeStamp,
    yellow,
  )
import System.Random (randomRIO)

getrandomTuple :: IO (Double, Double)
getrandomTuple = do
  x <- randomRIO (0, 1)
  y <- randomRIO (0, 1)
  return (x, y)

generateRandomTuples :: Int -> IO [(Double, Double)]
generateRandomTuples n = sequence (replicate n getrandomTuple)

getQ1 :: (Show a, Ord a, Floating a) => [(a, a)] -> IO ()
getQ1 xs =
  print
    . getAvgMaxStats
    . getWaitingTime
    . toTimeStamp
    $ map (\(x, y) -> (getArrivalTime x, getServiceTime y yellow)) xs

getQ2 :: (Show a, Ord a, Floating a) => [(a, a)] -> IO ()
getQ2 xs =
  print
    . getAvgMaxStats
    . getQueueLengthList
    . toTimeStamp
    $ map (\(x, y) -> (getArrivalTime x, getServiceTime y red)) xs

getQ3 :: (Show a, Ord a, Floating a) => [(a, a)] -> BankSim.Colour -> IO ()
getQ3 xs color =
  print
    . getAvgMaxStats
    . getWaitingTime
    . toTimeStamp
    $ map (\(x, y) -> (getArrivalTime x, getServiceTime y color)) xs

someFunc :: IO ()
someFunc = do
  -- The answer is generated multiple times to negate one-off spikes.
  randomTuples1 <- generateRandomTuples 10000
  randomTuples2 <- generateRandomTuples 10000
  randomTuples3 <- generateRandomTuples 10000

  print "Given only yellow customers, what are the average and maximum customer waiting times?"
  getQ1 randomTuples1
  getQ1 randomTuples2
  getQ1 randomTuples3

  print "Given only red customers, what are the average and maximum queue lengths in-front of the teller?"
  getQ2 randomTuples1
  getQ2 randomTuples2
  getQ2 randomTuples3

  print "Which type of customer(yellow, red or blue) gives the gives the closest value between the average and maximum customer waiting times?"
  getQ3 randomTuples1 yellow
  getQ3 randomTuples1 red
  getQ3 randomTuples1 blue
  print "The difference between the two values seems to be lowest for yellow."
