module Main where

import System.Environment
import Data.Foldable
import qualified Data.Set as S

collatz :: Integral a => a -> a
collatz n = case n `mod` 2 of 0 -> n `div` 2
                              1 -> 3*n + 1

chain :: Integral a => a -> [a]
chain = takeWhile (/= 1) . iterate collatz

chainUntilKnown :: Integral a => S.Set a -> a -> [a]
chainUntilKnown known start
  | collatz start `elem` known = [start]
  | otherwise = start : chainUntilKnown known (collatz start)

checkNextUnknown :: Integral a => S.Set a -> S.Set a
checkNextUnknown knownToCollapse = S.union knownToCollapse newKnown
  where firstUnknown = head $ filter (`notElem` knownToCollapse) [1..]
        newKnown = S.fromList $ chainUntilKnown knownToCollapse firstUnknown

checkAll :: Integral a => [S.Set a]
checkAll = iterate checkNextUnknown $ S.singleton 1

data Args = Args Int

handleArgs :: [String] -> Args
handleArgs [] = Args 10
handleArgs [setSize] = Args (read setSize :: Int)
handleArgs _ = error "usage: collatz [SETSIZE=10]"

main :: IO ()
main = do
  args <- getArgs
  let Args wantedSize = handleArgs args
      wantedSet = head . dropWhile ((< wantedSize) . S.size) $ checkAll
  traverse_ print $ S.toAscList wantedSet
