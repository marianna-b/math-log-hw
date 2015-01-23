import Lexer
import Syntax

main :: IO ()
main = do
  inp <- getContents
  case tok inp >>= syntExpr of
    Left err -> error err
    Right p -> putStr $ show p
