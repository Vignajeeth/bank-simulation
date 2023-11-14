module BankSim
  ( myadd,
    getArrivalTime,
    getServiceTime,
    toTimeStampHelper,
    toTimeStamp,
    getWaitingTime,
    getAvgMaxStats,
    waitingTimeStatsHelper,
    getQueueLength,
    getQueueLengthList,
    Colour,
    -- Person,
    -- PersonTimestamp,
    yellow,
    red,
    blue,
  )
where

data Colour = Colour {alpha :: Int, beta :: Int}

yellow :: Colour
yellow = Colour 2 5

red :: Colour
red = Colour 2 2

blue :: Colour
blue = Colour 5 1

-- data Person = Person {arriveTime :: Double, serviceTime :: Double}

-- data PersonTimestamp = PersonTimestamp {arriveTimeStamp :: Double, serviceTimeStamp :: Double}

myadd :: Int -> Int -> Int
myadd a b = a + b

getArrivalTime :: (Ord a, Floating a) => a -> a
getArrivalTime x
  | x < 0 = error "Less than 0"
  | x >= 1 = error "More than or equal to 1"
  | otherwise = -100 * log (1 - x)

getServiceTime :: (Ord a, Fractional a) => a -> Colour -> a
getServiceTime x c
  | x < 0 = error "Less than 0"
  | x >= 1 = error "More than or equal to 1"
  | otherwise = 200 * (x ^ (alpha c - 1)) * ((1 - x) ^ (beta c - 1))

toTimeStampHelper :: (Ord a, Fractional a) => (a, a) -> (a, a) -> (a, a)
toTimeStampHelper a b = (fst a + fst b, max (snd a + snd b) (fst a + fst b + snd b))

toTimeStamp :: (Ord a, Fractional a) => [(a, a)] -> [(a, a)]
toTimeStamp [] = []
toTimeStamp (x : xs) = scanl1 toTimeStampHelper ((fst x, fst x + snd x) : xs)

waitingTimeStatsHelper :: (Ord a, Fractional a) => (a, a) -> (a, a) -> (a, a)
waitingTimeStatsHelper a b = (max 0 (snd a - fst b), snd b)

getWaitingTime :: (Ord a, Fractional a) => [(a, a)] -> [a]
getWaitingTime [] = []
getWaitingTime (x : xs) = map fst (scanl1 waitingTimeStatsHelper ((0, snd x) : xs))

getAvgMaxStats :: (Ord a, Fractional a) => [a] -> (a, a)
getAvgMaxStats xs = (sum xs / fromIntegral (length xs), maximum xs)

getQueueLength :: (Ord a, Fractional a) => (a, a) -> [a] -> a
getQueueLength (x, y) xs = fromIntegral (length (takeWhile (< y) xs) - length (takeWhile (< x) xs))

getQueueLengthList :: (Ord a, Fractional a) => [(a, a)] -> [a]
getQueueLengthList xs = [getQueueLength t (map fst xs) | t <- xs]