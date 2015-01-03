module InputDeduction where

import Lexer
import Syntax

parseInput :: String -> ([String], String)
parseInput input = let (g, b) = splitByStile input in
  ((splitBy (==',') g), b)

splitByStile :: String -> (String, String)
splitByStile (x:xs) = case x of
  '|' -> let (c:cx) = xs in
    case c of
      '-' -> ([], cx)
      _ -> let (a, b) = splitByStile xs in
        (x:a, b)
  _ -> let (a, b) = splitByStile xs in
    (x:a, b)
splitByStile [] = ([], [])

splitBy :: (Char -> Bool) -> String -> [String]
splitBy f s = case dropWhile f s of
  "" -> []
  s' -> w : splitBy f s''
    where (w, s'') = break f s'

getNewHeader :: String -> String
getNewHeader input = let (g, b) = parseInput input in
  (linkBy "," (init g)) ++ "|-(" ++ (last g) ++ ")->" ++ b

linkBy :: String -> [String] -> String
linkBy _ (x:[]) = x
linkBy s (x:xs) = x ++ s ++ linkBy s xs
linkBy _ [] = []


getAssump :: String -> [Expr]
getAssump input = let (g, _) = parseInput input in
  getAssump' g

getAssump' :: [String] -> [Expr]
getAssump' (x:xs) = case alexScanTokens x >>= synt of
  Right e -> e:(getAssump' xs)
getAssump' [] = []

getDeductS :: String -> Expr
getDeductS input = let (_, b) = parseInput input in
  getDeductS' b


getDeductS' :: String -> Expr
getDeductS' x = case alexScanTokens x >>= synt of
  Right e -> e
