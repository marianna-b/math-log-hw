import Syntax
import Lexer
import ProofCheckerLib


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
