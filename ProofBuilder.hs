import ProofBuilderLib
import Syntax
import Lexer
import FastExpr
import qualified Data.Map.Strict as M
import qualified Data.ByteString.Char8 as B

genAppoint :: String -> Int -> String
genAppoint s i =
    let x = if i == 0 then "Л" else "И" in
    s ++ "=" ++ x

genRefute :: [String] -> Int -> String
genRefute (s:[]) i = genAppoint s i
genRefute (s:xs) i = genAppoint s (i `mod` 2) ++ "," ++ genRefute xs (i `div` 2)

putOut :: [Expr] -> IO ()
putOut [] = return ()
putOut (x:xs) = do
  B.putStrLn $ showExprFast x
  putOut xs

putOutProof :: Either ([String], Int) [Expr] -> IO ()
putOutProof ans = case ans of
 Left (a, b) -> putStrLn $ "Высказывание ложно при" ++ genRefute a b
 Right pr-> putOut pr
-----------------------------------------------------------------------------

parseExpr :: String -> Expr
parseExpr s = case tok s >>= syntExpr of
  Left err -> error err
  Right e -> e

loadProof :: String -> M.Map String Proof -> IO (M.Map String Proof)
loadProof s proofMap = do
  inp <- readFile $ "atom-proof/" ++ s
  case tok inp >>= syntProof of
    Left s -> error s
    Right prf -> return $ M.insert s prf proofMap 

loadProofs :: IO (M.Map String Proof)
loadProofs = loadProof "and00" M.empty >>=
             loadProof "and01" >>=
             loadProof "and10" >>=
             loadProof "and11" >>=
             loadProof "or00" >>=
             loadProof "or10" >>=
             loadProof "or01" >>=
             loadProof "or11" >>=
             loadProof "impl00" >>=
             loadProof "impl10" >>=
             loadProof "impl01" >>=
             loadProof "impl11" >>=
             loadProof "not0" >>=
             loadProof "not1" >>=
             loadProof "excluded_assumption"

             
main :: IO ()
main = do
  input <- getContents
  proofMap <- loadProofs
  putOutProof $ getProof proofMap $ parseExpr input
