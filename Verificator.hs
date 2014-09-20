module Verificator where

import VerificatorBase
import Syntax
import Lexer
import Axioms

verifLoop :: Context -> [String] -> IO ()
verifLoop ctx (x:xs) = do
  case alexScanTokens x >>= synt >>= verifExpr ctx of
    Right newCtx -> do
       putStrLn $ current $ last newCtx
       verifLoop newCtx xs
    Left err -> do
      putStrLn err

verifLoop _ [] = return ()

main :: IO ()
main = do
  input <- readFile "input"
  verifLoop initAxiom $ lines input
