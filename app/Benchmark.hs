module Main where

import Algorithms
import Data.Time.Clock
import Text.Printf

timeIt :: IO a -> IO (a, Double)
timeIt action = do
  start <- getCurrentTime
  result <- action
  end <- getCurrentTime
  return (result, realToFrac $ diffUTCTime end start)

main :: IO ()
main = do
  let predicates = 
        [ ("simple", \x -> x 3 || (not (x 0) && x 2))
        , ("complex", \x -> (x 0 && x 5) || (x 2 && not (x 3)) || (x 7 && x 9 && not (x 1)))
        , ("deep", \x -> x 15 || (not (x 0) && x 10 && not (x 5)))
        , ("superComplex", \x ->
          (x 1 && not (x 4) && (x 6 || not (x 8)))
          || ((not (x 0) && x 3 && (x 7 || (x 9 && not (x 2)))))
          || ((x 5 && (not (x 10) || x 11)) && (not (x 12) || (x 13 && x 14)))
          || (not (x 15) && (x 16 || (not (x 17) && (x 18 && not (x 19)))))
          || ((x 20 && x 21) && (not (x 22) || (x 23 && not (x 24))))
          || ((not (x 25) && not (x 26)) || (x 27 && (x 28 || not (x 29))))
       )
        ]
  
  putStrLn "Algorithm | Predicate | Time (s) | Result"
  putStrLn "----------|-----------|----------|-------"
  
  sequence_ [ do
    (r1, t1) <- timeIt $ return $! escardo predicate
    (r2, t2) <- timeIt $ probEscardo predicate 1000
    printf "Escardo   | %-9s | %.6f | %s\n" name t1 (maybe "Nothing" (const "Found") r1)
    printf "Prob-1K   | %-9s | %.6f | %.3f\n" name t2 r2
    | (name, predicate) <- predicates ]