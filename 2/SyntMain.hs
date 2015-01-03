import Lexer
import Syntax

main = do 
  inStr <- getContents
  putStrLn $ case alexScanTokens inStr >>= synt of
    Right tree -> show tree
    Left err -> "ERROR: " ++ err
