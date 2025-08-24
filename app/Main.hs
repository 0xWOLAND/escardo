module Main where

import Algorithms
import qualified Data.IntMap.Strict as IM
import System.Environment (getArgs)

predicate :: Pred
predicate x = x 3 || (not (x 0) && x 2)

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["sme"] -> do
      fs <- sme predicate
      putStrLn $ "SME: " ++ show (length fs) ++ " frontier cylinders"
      mapM_ (putStrLn . show . IM.toList) fs
    ["escardo"] -> case escardo predicate of
      Nothing -> putStrLn "Escardo: no witness"
      Just w -> putStrLn $ "Escardo: witness " ++ showBits w 12
    ["prob"] -> do
      measure <- probEscardo predicate 5000
      putStrLn $ "Prob: measure ≈ " ++ show measure
    ["all"] -> do
      fs <- sme predicate
      putStrLn $ "SME: " ++ show (length fs) ++ " frontier cylinders"
      case escardo predicate of
        Nothing -> putStrLn "Escardo: no witness"
        Just w -> putStrLn $ "Escardo: witness " ++ showBits w 12
      measure <- probEscardo predicate 5000
      putStrLn $ "Prob: measure ≈ " ++ show measure
    _ -> putStrLn "Usage: escardo [sme|escardo|prob|all]"