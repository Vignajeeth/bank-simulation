module Main where

import BankSim
  ( Colour,
    -- Person,
    -- PersonTimestamp,
    blue,
    getArrivalTime,
    getAvgMaxStats,
    getQueueLength,
    getQueueLengthList,
    getServiceTime,
    getWaitingTime,
    myadd,
    red,
    toTimeStamp,
    toTimeStampHelper,
    waitingTimeStatsHelper,
    yellow,
  )
import Test.Tasty (TestTree, defaultMain, testGroup)
import Test.Tasty.HUnit (assertEqual, assertFailure, testCase)

main :: IO ()
main = do
  defaultMain
    ( testGroup
        "Tests"
        [ myaddTest,
          getArrivalTimeTest,
          toTimeStampTest,
          getWaitingTimeTest,
          getAvgMaxStatsTest,
          getQueueLengthListTest
        ]
    )

myaddTest :: TestTree
myaddTest =
  testCase
    "Testing myadd"
    $ do
      (assertEqual "7+3=10" 10 (myadd 7 3))
      (assertEqual "6+4=10" 10 (myadd 6 4))

getArrivalTimeTest :: TestTree
getArrivalTimeTest =
  testCase
    "Testing getArrivalTime"
    $ do
      (assertEqual "" 10.536051565782628 (getArrivalTime 0.1))
      (assertEqual "" 22.31435513142097 (getArrivalTime 0.2))
      (assertEqual "" 230.25850929940458 (getArrivalTime 0.9))

-- getServiceTimeTest :: TestTree
-- getServiceTimeTest =
--   testCase
--     "Testing getServiceTime"
--     $ do
--       (assertEqual "" 13.122 (getServiceTime 0.1 yellow))

toTimeStampTest :: TestTree
toTimeStampTest =
  testCase
    "Testing toTimeStamp"
    $ do
      ( assertEqual
          ""
          [(1, 11), (16, 26), (17, 36), (32, 46), (33, 56)]
          (toTimeStamp [(1, 10), (15, 10), (1, 10), (15, 10), (1, 10)])
        )

getWaitingTimeTest :: TestTree
getWaitingTimeTest =
  testCase
    "Testing getWaitingTime"
    $ do
      ( assertEqual
          ""
          [0, 0, 9, 4, 13]
          (getWaitingTime . toTimeStamp $ [(1, 10), (15, 10), (1, 10), (15, 10), (1, 10)])
        )

getAvgMaxStatsTest :: TestTree
getAvgMaxStatsTest =
  testCase
    "Testing getAvgMaxStats"
    $ do
      ( assertEqual
          ""
          (5.2, 13)
          (getAvgMaxStats [0, 0, 9, 4, 13])
        )
      ( assertEqual
          ""
          (1.8, 3)
          (getAvgMaxStats [1, 2, 3, 2, 1])
        )

getQueueLengthListTest :: TestTree
getQueueLengthListTest =
  testCase
    "Testing getQueueLengthList"
    $ do
      ( assertEqual
          ""
          [1, 2, 3, 2, 1]
          (getQueueLengthList . toTimeStamp $ [(1, 10), (15, 10), (1, 10), (15, 10), (1, 10)])
        )