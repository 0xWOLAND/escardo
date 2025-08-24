module Algorithms where

import qualified Data.IntMap.Strict as IM
import Data.IntMap.Strict (IntMap)
import Control.Exception
import Data.Typeable (Typeable)
import System.IO.Unsafe (unsafePerformIO)
import System.Random

type Oracle = Int -> Bool -- This is over the Cantor space
type Pred = Oracle -> Bool
type Prefix = IntMap Bool

data Need = Need !Int deriving (Show, Typeable)
instance Exception Need

oracle :: Prefix -> Oracle
oracle asg i = maybe (throw (Need i)) id (IM.lookup i asg)

evalP :: Pred -> Prefix -> Either Int Bool
evalP p asg = case unsafePerformIO (try (evaluate (p (oracle asg))) :: IO (Either Need Bool)) of
  Left (Need i) -> Left i
  Right b -> Right b

sme :: Pred -> IO [Prefix]
sme p = go IM.empty where
  go asg = case evalP p asg of
    Right True -> pure [asg]
    Right False -> pure []
    Left i -> do
      f0 <- go (IM.insert i False asg)
      f1 <- go (IM.insert i True asg)
      pure (f0 ++ f1)

escardo :: Pred -> Maybe Oracle
escardo p = fmap extend (go IM.empty) where
  extend asg i = IM.findWithDefault False i asg
  go asg = case evalP p asg of
    Right True -> Just asg
    Right False -> Nothing
    Left i -> case go (IM.insert i False asg) of
      Just a -> Just a
      Nothing -> go (IM.insert i True asg)

randOracle :: StdGen -> Oracle
randOracle gen i = fst $ random (mkStdGen (seed + i))
  where seed = fst $ random gen :: Int

probEscardo :: Pred -> Int -> IO Double
probEscardo p n = do
  gen <- newStdGen
  let (gen1, gen2) = split gen
      makeGens g 0 = []
      makeGens g m = g : makeGens (snd $ split g) (m-1)
      gens = makeGens gen2 n
      hits = length [() | g <- gens, p (randOracle g)]
  return $ fromIntegral hits / fromIntegral n

showBits :: Oracle -> Int -> String
showBits x n = show [x i | i <- [0..n-1]]