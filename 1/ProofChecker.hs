import Syntax
import Lexer
import ProofCheckerLib

verifLoop :: Context -> [Expr] -> Context
verifLoop ctx (x:[])  = case runVerifier ctx x of
  Right newCtx -> newCtx

verifLoop ctx (x:xs) = case runVerifier ctx x of
  Right newCtx -> verifLoop newCtx xs
  Left _ -> verifLoop ctx xs

parseProof :: [String] -> [Expr]
parseProof [] = []
parseProof (x:xs) = case alexScanTokens x >>= synt of
  Right e -> [e] ++ parseProof xs

putOut :: Int -> Context -> IO ()
putOut _ [] = return ()
putOut n (x:xs) = do
  putStrLn $ "(" ++ (show n) ++ ") " ++ show x
  putOut (n + 1) xs

main :: IO ()
main = do
  s <- getLine
  input <- readFile s
  putOut 1 $ verifLoop [] $ parseProof (lines input)
