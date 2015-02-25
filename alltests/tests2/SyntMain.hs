import LexerDeduction
import SyntaxDeduction

main = do 
  inStr <- getContents
  putStrLn $ case tokDeduct inStr >>= syntDeduct of
    Right tree -> show tree
    Left err -> "ERROR: " ++ err
