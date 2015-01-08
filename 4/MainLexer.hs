import Lexer

main :: IO ()
main = do
  inp <- getContents
  case tok inp of
    Left err -> error err
    Right p -> putStr $ show p
