import qualified Data.Map.Strict as M
import Lexer
import Syntax
import FAApplyDeductionLib
import FAModusPonens
import FASubstitutions
import ProofsQuantifiers
import Debug.Trace
import OutQuantifiersProofLib

parseInput :: String -> Expr
parseInput s1 =
  let s = head (lines s1) in
  case tok s >>= syntExpr of
    Left err -> error err
    Right e -> e

main :: IO ()
main = do
  inp <- getContents
  proofMap <- getProofMap
  putStr $ show $ getOutQuantDeduct proofMap $ parseInput inp
