import qualified Data.Map.Strict as M
import Lexer
import Syntax
import FAProofCheckLib 
import FAApplyDeductionLib
import FAModusPonens
import ProofsQuantifiers

data ResultOutQ = ResultOutQ {
                 changed :: Bool,
                 inExpr ::Expr,
                 outExpr :: Expr,
                 eqProof :: Proof
                 }

parseInput :: String -> Expr
parseInput s = case tok s >>= syntExpr of
                 Left err -> error err
                 Right e -> e
main :: IO ()
main = do
  inp <- getContents
  proofMap <- getProofMap
  putStr $ show $ getOutQuantDeduct proofMap $ parseInput inp

getMapOfQuant :: Expr -> M.Map String Int
getMapOfQuant = undefined

outQ :: [String] -> M.Map String Int -> Expr -> ResultOutQ
outQ = undefined

getOutQuantDeduct :: ProofMap -> Expr -> DeductionProof
getOutQuantDeduct proofMap e =
    let frees = freeV e in
    let mapQuant = getMapOfQuant e in
    let result = outQ frees mapQuant e in
    if 
