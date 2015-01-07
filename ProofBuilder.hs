import ProofBuilderLib
import Syntax
import Lexer

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
  putStrLn $ show x
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

main :: IO ()
main = do
  input <- getContents
  putOutProof $ getProof $ parseExpr input
