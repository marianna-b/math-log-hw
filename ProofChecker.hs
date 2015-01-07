import Syntax
import Lexer
import ProofCheckerLib2
import qualified Data.Map.Strict as M

parseProof :: [String] -> [Expr]
parseProof [] = []
parseProof (x:xs) = case tok x >>= syntExprNoEoln of
  Right e -> e:(parseProof xs)
  Left err -> error err

putOut :: Int -> Context -> IO ()
putOut _ [] = return ()
putOut n (x:xs) = do
  putStrLn $ "(" ++ (show n) ++ ") " ++ show x
  putOut (n + 1) xs

main :: IO ()
main = do
  input <- getContents
  let mps = MPsMap M.empty M.empty M.empty
  putOut 1 $ verifLoop mps [] $ parseProof $ lines input
