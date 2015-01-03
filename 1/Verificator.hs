--module Verificator where

import Prover
import Syntax
import Lexer

verifLoop :: Context -> Int -> [String] -> IO ()
verifLoop ctx n (x:xs) = do
  case alexScanTokens x >>= synt >>= runVerifier ctx of
      Right newCtx -> do
        putStrLn $ getResStr x n $ current $ last newCtx
        verifLoop newCtx (n + 1) xs
      Left err -> do
          putStrLn (getResStr x n err)
          verifLoop ctx (n + 1) xs
verifLoop _ _ []  = return ()

getResStr :: String -> Int -> String -> String
getResStr x n note =
  "(" ++ (show n) ++ ") " ++ (unSpace x) ++ " (" ++ note ++ ")"

unSpace :: String -> String
unSpace s = concat $ words s

main :: IO ()
main = do
  s <- getLine
  input <- readFile s
  verifLoop [] 1 $ lines input
