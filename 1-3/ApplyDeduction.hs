import Syntax
import Lexer
import ApplyDeductionLib

getDeductedProof :: DeductionProof -> Either String DeductionProof
getDeductedProof p =
    let stmt = statement p in
    let assump = init $ assumption p in
    let prf = proof p in
    let lastAssump = last $ assumption p in
    buildNewDProof stmt lastAssump assump prf

buildNewDProof :: Expr -> Expr -> [Expr] -> [Expr] -> Either String DeductionProof
buildNewDProof s a assump prf =
  let newProof = getNewProof a assump prf in
    case newProof of
      Left str -> Left str
      Right pr -> Right $ DeductionProof (a ~> s) assump pr

applyDeduct :: String -> Either String DeductionProof
applyDeduct s = getDeductedProof $ parseInput s

parseInput :: String -> DeductionProof
parseInput inp =
  let l = lines inp in
  let a = head l in
  case tok a >>= syntAssump of
    Left err -> error err
    Right d ->
        case tok (unlines (tail l)) >>=  syntProof of
          Left e -> error e
          Right prf ->
              DeductionProof (statement d) (assumption d) prf

main :: IO ()
main = do
  input <- getContents
  case applyDeduct input of
    Left err -> putStr err
    Right prf -> putStr $ show prf
